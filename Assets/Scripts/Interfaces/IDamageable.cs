using System.Collections;

public interface IDamageable
{
    IEnumerator ReceiveDmg(float dmg, CharacterModel model);
}
