using System.Collections;
using UnityEngine;

public class HeroModel : CharacterModel
{
	[Header("Stats")]
	public float playerBaseAtk;

	public int playerMetal;
	public int weaponUsesRemaining;
	
	public bool playerSeriouslyInjured;

	public string currentWeapon;
	
	[Header("Refs")]
	public GameObject sword;
	public GameObject scifiContainer;
	public GameObject metalGear;
	public Animator anim;
	public ParticleSystem damgeVFX;
	private Rigidbody rb;

	[Header("Movement")]
	public float moveSpeed;
	public float rotationSpeed;

	[Header("Interaction")]
	public float interactionRange = 1f;

	[Header("VFX")]
	public SkinnedMeshRenderer myRenderer;
	private Material topMaterial;
	private Material bottomMaterial;
	public SceneShaderManager shaderManager;

	public float PlayerAtk { get { return (playerBaseAtk * (playerSeriouslyInjured ? 0.5f : 1f)) + (currentWeapon == "Sword" ? World.Config.swordAtkDmg : 0); } }

	private Vector3 startPos;

	void Awake()
	{
		rb = GetComponent<Rigidbody>();
		startPos = transform.position;
		sword.SetActive(currentWeapon == "Sword");
		scifiContainer.SetActive(false);
		metalGear.SetActive(false);

		bottomMaterial = myRenderer.materials[0];
		topMaterial = myRenderer.materials[1];
	}

	public void ResetModel(WorldStateConfig config)
	{
		CharacterMaxLife = config.playerMaxLife;
		CharacterCurrLife = CharacterMaxLife;
		playerSeriouslyInjured = false;
		shaderManager.PlayerIsSeriouslyInjured(playerSeriouslyInjured);
		UpdateBloodySkinAndLifeBar();

		playerBaseAtk = config.playerBaseAtk;

		currentWeapon = config.currentWeapon;
		weaponUsesRemaining = config.weaponUsesRemaining;

		playerMetal = config.playerMetal;

		transform.position = startPos;
		rb.velocity *= 0f;
	}

	void FixedUpdate()
	{
		Vector3 vel = rb.velocity;
		vel.x *= 0.9f;
		vel.z *= 0.9f;
		rb.velocity = vel;
	}

	private void UpdateBloodySkinAndLifeBar()
	{
		float lifePercentage = CharacterCurrLife / CharacterMaxLife;
		shaderManager.UpdateLifeBarMesh(lifePercentage);
		topMaterial.SetFloat("_BloodAmount", lifePercentage);
		bottomMaterial.SetFloat("_BloodAmount", lifePercentage);
	}

	public void Move(Vector3 dir)
	{
		dir.y = 0;
		rb.velocity += (dir * moveSpeed) * Time.deltaTime;
		anim.Play("Hero Run");
		Face(dir);
	}

	public void Face(Vector3 dir)
	{
		Vector3 direction = new Vector3(dir.x, 0, dir.z);
		transform.forward = Vector3.Slerp(transform.forward, direction, rotationSpeed * Time.deltaTime);
	}

	public void Stop()
	{
		rb.velocity *= 0f;
	}

	Collider[] results = new Collider[10];
	public IEnumerator TryInteract()
	{
		if (Physics.OverlapSphereNonAlloc(transform.position, interactionRange, results) > 0)
		{
			foreach (var col in results)
			{
				if (col == null) continue;
				var interactable = col.GetComponentInParent<IInteractable>();
				if (interactable == null) continue;

				Vector3 interactablePosition = new Vector3(col.transform.position.x, 0, col.transform.position.z);
				transform.LookAt(interactablePosition);

				yield return interactable.Interact(this);

				yield break;
			}
		}
	}

	public IEnumerator TryAttack()
	{
		if (Physics.OverlapSphereNonAlloc(transform.position, interactionRange, results) > 0)
		{
			foreach (Collider col in results)
			{
				if (col == null) continue;
				IDamageable damageable = col.GetComponentInParent<IDamageable>();
				if (damageable == null) continue;
				if (damageable == this) continue;

				transform.LookAt(World.Instance.boss.transform.position);
				int randomAnimNumber = Random.Range(0, 1);
				string animSwordName = randomAnimNumber == 0 ? "HeroAttack 1" : "HeroAttack 2";
				string animPunchName = randomAnimNumber == 0 ? "HeroPunch 1" : "HeroPunch 2";

				if (currentWeapon == "Sword")
					anim.Play(animSwordName);
				else
					anim.Play(animPunchName);

				yield return new WaitForSeconds(0.5f);
				yield return damageable.ReceiveDmg(PlayerAtk, this);
				
				ConsumeWeapon(1);
				yield break;
			}
		}
	}

	public override IEnumerator ReceiveDmg(float dmg, CharacterModel model)
	{
		damgeVFX.Stop();
		damgeVFX.Play();

		shaderManager.PlayerHitReaction();

		yield return base.ReceiveDmg(dmg, model);
		if (CharacterCurrLife < World.Config.playerInjuredLife)
		{
			playerSeriouslyInjured = true;
			shaderManager.PlayerIsSeriouslyInjured(playerSeriouslyInjured);
			UpdateBloodySkinAndLifeBar();
		}

		yield return null;
	}

	public void ConsumeWeapon(int usesConsumed)
	{
		weaponUsesRemaining -= usesConsumed;
		if (weaponUsesRemaining <= 0)
		{
			weaponUsesRemaining = 0;
			currentWeapon = "None";
			sword.SetActive(false);
		}
	}

	public void GetWeapon()
	{
		currentWeapon = "Sword";
		sword.SetActive(true);
	}

	public IEnumerator Sleep(RestMachine restMachine, ParticleSystem levitationVFX)
	{
		Vector3 lastPos = transform.position;
		Quaternion lastRot = transform.rotation;
		
		rb.isKinematic = true;

		transform.position = restMachine.sleepPosition.position;
		transform.eulerAngles = restMachine.sleepPosition.eulerAngles;
		levitationVFX.Play();
		anim.Play("Hero Rest");

		yield return new WaitForSeconds(3.0f);

		levitationVFX.Stop();
		anim.Play("Hero Idle");

		rb.isKinematic = false;
		transform.position = lastPos;
		transform.rotation = lastRot;

		CharacterCurrLife = Mathf.Clamp(CharacterCurrLife + World.Config.restLifeHeal, 0, CharacterMaxLife);
		playerSeriouslyInjured = false;
		shaderManager.PlayerIsSeriouslyInjured(playerSeriouslyInjured);
		UpdateBloodySkinAndLifeBar();
	}

	public IEnumerator Work(WorkZone work)
	{
		rb.isKinematic = true;
		transform.position = work.workZonePosition.position;
		transform.LookAt(new Vector3(work.transform.position.x, 0, work.transform.position.z));
		
		scifiContainer.SetActive(true);
		anim.Play("Hero Work");

		yield return new WaitForSeconds(2.5f);

		scifiContainer.SetActive(false);
		metalGear.SetActive(false);
		anim.Play("Hero Idle");

		rb.isKinematic = false;
		playerMetal += World.Config.workMetalPay;
	}

	public IEnumerator WeaponFactory(FactoryWeapon factory, ParticleSystem factoryVFX)
	{
		factoryVFX.Play();
		rb.isKinematic = true;
		transform.position = factory.factoryZonePosition.position;
		transform.LookAt(new Vector3(factory.transform.position.x, 0, factory.transform.position.z));
		anim.Play("Hero Factory");

		yield return new WaitForSeconds(2.2f);

		anim.Play("Hero Idle");
		rb.isKinematic = false;

		playerMetal -= World.Config.buyWeaponMetalNeeded;
		GetWeapon();
		weaponUsesRemaining = World.Config.swordMaxUses;
		factoryVFX.Stop();
	}

	public IEnumerator GymWorkout(Gym thisGym)
	{
		rb.isKinematic = true;
		transform.position = thisGym.gymPosition.position;
		transform.LookAt(new Vector3(thisGym.transform.position.x, 0, thisGym.transform.position.z));

		string animName = currentWeapon == "Sword" ? "Hero Gym" : "Hero GymNW";
		anim.Play(animName);
		
		yield return new WaitForSeconds(2.5f);

		anim.Play("Hero Idle");
		rb.isKinematic = false;

		CharacterMaxLife += World.Config.trainMaxLifeIncr;
		playerBaseAtk += currentWeapon == "Sword" ? World.Config.trainAtkIncr * World.Config.trainWithWeaponMultiplier : World.Config.trainAtkIncr;
		ConsumeWeapon(World.Config.trainWeaponUses);

	}

	protected override void Death()
	{
		anim.Play("Hero Death");
	}

	#region AnimationEvents
	public void OnWorkAnimationEventStart()
	{
		metalGear.SetActive(true);
	}

	public void OnWorkAnimationEventEnd()
	{
		metalGear.SetActive(false);
	}

	public void OnPunchStart()
	{
		shaderManager.GymBagPunched(true);
	}

	public void OnPunchEnd()
	{
		shaderManager.GymBagPunched(false);
	}
	#endregion;

	private void OnDrawGizmos()
	{
		Gizmos.color = Color.yellow;
		Gizmos.DrawWireSphere(transform.position, interactionRange);
	}
}
