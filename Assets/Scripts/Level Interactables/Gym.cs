using System.Collections;
using UnityEngine;

public class Gym : MonoBehaviour, IInteractable
{
    public Transform gymPosition;

    public IEnumerator Interact(HeroModel model)
    {
        Debug.Log("Workout Time! I wanna be like John Cena someday");
        yield return model.GymWorkout(this);
    }
}
