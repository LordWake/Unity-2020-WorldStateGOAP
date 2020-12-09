using System.Collections;
using UnityEngine;

public class BossModel : CharacterModel
{
    public float bossAtk;

    public Animator anim;
    public ParticleSystem damageVFX;

    public SkinnedMeshRenderer myRenderer;

    private Material topMaterial;
    private Material bottomMaterial;

    private float lifePercentage;

    public SceneShaderManager shaderManager;

    void Awake()
	{
        topMaterial = myRenderer.materials[0];
        bottomMaterial = myRenderer.materials[1];
    }

	void Start()
    {
        bossAtk = World.Config.bossAtk;
        CharacterMaxLife = World.Config.bossMaxLife;
        CharacterCurrLife = CharacterMaxLife;

        UpdateLifePercentageAndSkin();
    }

    public override IEnumerator ReceiveDmg(float dmg, CharacterModel model)
    {
        damageVFX.Stop();
        damageVFX.Play();

        yield return base.ReceiveDmg(dmg, model);
        UpdateLifePercentageAndSkin();
        yield return new WaitForSeconds(0.5f);
        
        if (CharacterCurrLife > 0)
        {
            transform.LookAt(model.transform, Vector3.up);
            
            int randomAnimNumber = Random.Range(0, 1);
            string animName = randomAnimNumber == 0 ? "BossAttack 1" : "BossAttack 2";
            
            anim.Play(animName);
            yield return new WaitForSeconds(0.5f);
            yield return model.ReceiveDmg(bossAtk, this);
        }
    }

    private void UpdateLifePercentageAndSkin()
	{
        lifePercentage = CharacterCurrLife / CharacterMaxLife;
        topMaterial.SetFloat("_BloodAmount", lifePercentage);
        bottomMaterial.SetFloat("_BloodAmount", lifePercentage);
    }

    protected override void Death()
    {
        //I did this so we can see the nice "Dissolve" shader when the boss dies.
        shaderManager.PlayerIsSeriouslyInjured(false);
        anim.Play("Boss Death");
    }

    public void OnDeadAnimationEvent()
	{
        shaderManager.OnBossDead();
    }
}
