using System.Collections;
using UnityEngine;

public class WorkZone : MonoBehaviour, IInteractable
{
    public Transform workZonePosition;

    public IEnumerator Interact(HeroModel model)
    {
        yield return model.Work(this);
        Debug.Log("Collecting Junk... You earned " + World.Config.workMetalPay + " pieces of metal lml");
    }
}
