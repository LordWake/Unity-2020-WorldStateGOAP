using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class UIManager : MonoBehaviour
{
	//This is a really bad UI, it should use an observer or something like that instead of an Update!

	private bool hudFlipFlop;
	public GameObject canvasObject;

	[Header("Character's Modfel")]
	public BossModel myBoss;
	public HeroModel myHero;

	[Header("UI Text")]
	public Text bossMaxLife;
	public Text bossCurrentLife;
	
	public Text heroMaxLife;
	public Text heroCurrentLife;
	public Text heroJunkAmount;
	public Text heroTypeOfWeapon;
	public Text heroWeaponUses;

	void Awake()
	{
		hudFlipFlop = true;
	}

	void Update()
	{
		CheckInputs();
		UpdateHUDInfo();
	}

	private void CheckInputs()
	{
		if(Input.GetKeyDown(KeyCode.X))
		{
			hudFlipFlop = !hudFlipFlop;
			SwitchHUD(hudFlipFlop);
		}
		if (Input.GetKeyDown(KeyCode.Z))
			ResetThisScene();
	}

	private void SwitchHUD(bool enableHUD)
	{
		if(enableHUD)
			canvasObject.SetActive(true);
		else
			canvasObject.SetActive(false);
	}

	private void UpdateHUDInfo()
	{
		if (!hudFlipFlop) return;
		
		if(canvasObject.activeInHierarchy)
		{
			bossMaxLife.text = myBoss.CharacterMaxLife.ToString();
			bossCurrentLife.text = myBoss.CharacterCurrLife.ToString();

			heroMaxLife.text = myHero.CharacterMaxLife.ToString();
			heroCurrentLife.text = myHero.CharacterCurrLife.ToString();
			heroJunkAmount.text = myHero.playerMetal.ToString();
			heroTypeOfWeapon.text = myHero.currentWeapon;
			heroWeaponUses.text = myHero.weaponUsesRemaining.ToString();
		}
	}

	private void ResetThisScene()
	{
		SceneManager.LoadScene(SceneManager.GetActiveScene().name);
	}
}
