using UnityEngine;

public class World : MonoBehaviour
{
    static public World Instance { get; private set; }

    void Awake()
    {
        if (Instance == null)
            Instance = this;
        else
            Destroy(gameObject);
    }

    [SerializeField]
    private WorldStateConfig config;

    static public WorldStateConfig Config { get { return Instance.config; } }

    public Transform restMachine;
    public Transform weaponsFactory;
    public Transform workZone;
    public Transform gym;
    public BossModel boss;
}
