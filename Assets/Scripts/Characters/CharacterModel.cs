using System.Collections;
using UnityEngine;

public class CharacterModel : MonoBehaviour, IDamageable
{
    [Header("Stats")]
    [SerializeField]
    private float characterMaxLife;
    public float CharacterMaxLife { get { return characterMaxLife; } set { characterMaxLife = value;}}
    [SerializeField]
    private float characterCurrLife;
    public float CharacterCurrLife { get { return characterCurrLife; } set { characterCurrLife = value;}}


    public virtual IEnumerator ReceiveDmg(float dmg, CharacterModel model)
    {
        CharacterCurrLife -= dmg;
        CharacterCurrLife = Mathf.Clamp(CharacterCurrLife, 0, CharacterMaxLife);
        if (CharacterCurrLife <= 0)
            Death();

        yield return null;
    }

    protected virtual void Death() {}
}
