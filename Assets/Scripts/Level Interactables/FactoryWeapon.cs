using System.Collections;
using UnityEngine;

public class FactoryWeapon : MonoBehaviour, IInteractable
{
    public Transform factoryZonePosition;
    public ParticleSystem raysVFX;

    public IEnumerator Interact(HeroModel model)
    {
        if (model.playerMetal < World.Config.buyWeaponMetalNeeded)
        {
            Debug.LogWarning("Factory// There's not enough metal to buy. You are not so rockstar after all");
            yield break;
        }

        yield return model.WeaponFactory(this, raysVFX);
        Debug.Log("Factory Success! Now you have a beautiful sword made with stolen 3D Models from internet");
    }
}
