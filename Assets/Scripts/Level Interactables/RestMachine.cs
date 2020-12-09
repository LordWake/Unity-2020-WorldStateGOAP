using System.Collections;
using UnityEngine;

public class RestMachine : MonoBehaviour, IInteractable
{
    public Transform sleepPosition;
    public ParticleSystem sleepVFX;
   
    public IEnumerator Interact(HeroModel model)
    {
        yield return model.Sleep(this, sleepVFX);
        Debug.Log("Sleep in Levitation weird stuff. You earned " + (World.Config.restLifeHeal + " HP"));
    }
}
