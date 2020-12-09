using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

public class SceneShaderManager : MonoBehaviour
{
    public MeshRenderer gymBagRenderer;
    public MeshRenderer playerLifeBarRenderer;
    public SkinnedMeshRenderer bossMeshRenderer;
    public GameObject spaceUIShader;
    
    private Material gymBagMaterial;
    private Material playerLifeBarMaterial;

    public Material bossTOPDisolve;
    public Material bossBottomDisolve;

    public float dissolveSpeed = 0.0f;


    //POST-PROCESS SHADERS
    public Camera replacementCamera;
    public Shader PlayerLifeReplacementShader;
    public Shader SpecialZonesReplacementShader;

    public Color normalLifeColor;
    public Color middleLifeColor;
    public Color lowLifeColor;

    private float playerDamagedSpeed    = 0.5f;
    private float hitReactionSpeed      = 100.0f;
    private float playerLifeValue       = 1.0f;

    [Range(0,0.5f)]
    private float playerDamagedLerp = 0.0f;

    private PostProcessPlayerDamagedPPSSettings playerDamagedPPSettings;
    private PostProcessHitReactionPPSSettings playerHitReactionPPSettings;
    private PostProcessVolume postProcessVolume;


    void Awake()
    {
        gymBagMaterial          = gymBagRenderer.materials[0];
        playerLifeBarMaterial   = playerLifeBarRenderer.materials[0];
        
        postProcessVolume = FindObjectOfType<PostProcessVolume>();
        postProcessVolume.profile.TryGetSettings(out playerDamagedPPSettings);
        postProcessVolume.profile.TryGetSettings(out playerHitReactionPPSettings);
        
        playerDamagedPPSettings.active = false;
        playerHitReactionPPSettings.active = false;

        replacementCamera.enabled = false;
    }

    void Update()
	{
        PlayerDamagedPostProcessEffectUpdate();
        CheckReplacementInputs();    
    }

    private void CheckReplacementInputs()
    {
        if (Input.GetKeyDown(KeyCode.Alpha1))
        {
            replacementCamera.ResetReplacementShader();
            replacementCamera.enabled = false;
        }

        else if (Input.GetKeyDown(KeyCode.Alpha2))
        {
            replacementCamera.enabled = true;
            replacementCamera.ResetReplacementShader();
            ReplacementPlayerLifeValue();
        }

        else if (Input.GetKeyDown(KeyCode.Alpha3))
        {
            replacementCamera.enabled = true;
            replacementCamera.ResetReplacementShader();
            ReplacementSpecialZones();
        }

    }

    private void PlayerDamagedPostProcessEffectUpdate()
	{
        if (!playerDamagedPPSettings.enabled) return;

        playerDamagedLerp += playerDamagedSpeed * Time.deltaTime;
        playerDamagedLerp = playerDamagedLerp >= 0.5f ? 0 : playerDamagedLerp;
        playerDamagedPPSettings._LerpRed.value = playerDamagedLerp;
    }

    private void ReplacementPlayerLifeValue()
    {
        replacementCamera.SetReplacementShader(PlayerLifeReplacementShader, "ReplacementPlayer");

        Color tempColor = playerLifeValue > 0.75f ? normalLifeColor :
                          playerLifeValue < 0.75f && playerLifeValue > 0.30f ? middleLifeColor :
                          lowLifeColor;

        Shader.SetGlobalColor("_LifeTint", tempColor);
    }

    private void ReplacementSpecialZones()
	{
        replacementCamera.SetReplacementShader(SpecialZonesReplacementShader, "ReplacementZones");
    }

    public void GymBagPunched(bool isPunched)
	{
        if (isPunched)
            gymBagMaterial.SetFloat("_PunchIntensity", 0.5f);
        else
            gymBagMaterial.SetFloat("_PunchIntensity", 0.0f);
    }

    public void OnGameStar()
	{
        spaceUIShader.SetActive(false);
	}

    public void PlayerIsSeriouslyInjured(bool damaged)
	{
        playerDamagedPPSettings.active = damaged;
    }

    public void PlayerHitReaction()
    {
        StopAllCoroutines();
        StartCoroutine(PlayerHitEffect());
    }

    public void UpdateLifeBarMesh(float lifeValue)
	{
        playerLifeValue = lifeValue;
        playerLifeBarMaterial.SetFloat("_LifeValue", playerLifeValue);

        Color tempColor = playerLifeValue > 0.75f ? normalLifeColor :
                  playerLifeValue < 0.75f && playerLifeValue > 0.25f ? middleLifeColor :
                  lowLifeColor;

        Shader.SetGlobalColor("_LifeTint", tempColor);
    }

    public void OnBossDead()
	{
        Material[] materialsArray = new Material[] {bossTOPDisolve, bossBottomDisolve};
        bossMeshRenderer.sharedMaterials = materialsArray;

        StartCoroutine(DissolveEffectOnBoss(-1.0f));
    }

    IEnumerator PlayerHitEffect()
	{
        playerHitReactionPPSettings.active = true;
        playerHitReactionPPSettings._MoveScene.value = 0;
        bool minimumValue = false;

        while (playerHitReactionPPSettings._MoveScene.value < 25.0f)
		{
            if(playerHitReactionPPSettings._MoveScene.value >=  -25.0f && !minimumValue)
			{
                playerHitReactionPPSettings._MoveScene.value -= hitReactionSpeed * Time.deltaTime;
			}

            else
			{
                minimumValue = true;
                playerHitReactionPPSettings._MoveScene.value += hitReactionSpeed * Time.deltaTime;
			}
            
            yield return new WaitForEndOfFrame();
        }
        
        playerHitReactionPPSettings._MoveScene.value = 0;
        playerHitReactionPPSettings.active = false;
    }

    IEnumerator DissolveEffectOnBoss(float initialValue)
	{
        while(initialValue < 1)
		{
            initialValue += dissolveSpeed * Time.deltaTime;
            
            bossTOPDisolve.SetFloat("_DissolveAmount", initialValue);
            bossBottomDisolve.SetFloat("_DissolveAmount", initialValue);
            
            yield return new WaitForSeconds(0.05f);
		}
	}
}
