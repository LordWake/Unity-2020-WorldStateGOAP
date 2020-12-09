using System.Collections.Generic;
using UnityEngine;
using System.Linq;

public class WaypointsMatrix : MonoBehaviour
{
    static public WaypointsMatrix Instance { get; private set; }

    [Header("Refs")]
    public float cellSize;
    public Transform gridCenter;

    [Header("Parameters")]
    [Range(1, 50)]
    public int AI_GridSizeX;
    [Range(1, 50)]
    public int AI_GridSizeY;
    public int maxPathfindSteps = 30;
    
    public LayerMask obstacleDetectionLayer;
    public float obstacleDetectionRadius = 0.5f;

    [Header("Gizmos")]
    public bool drawGizmos;

    private Vector2 halfTileSize = Vector2.one;
    private Vector2 centerPos;
    
    private int AI_GridHalfSizeX, AI_GridHalfSizeY;
    private AI_Node[] _nodes;

    private void Awake()
    {
        if (Instance == null)
        { 
            Instance = this; 
            Initialize(); 
        }
        else
            Destroy(gameObject);
    }

    private void Initialize()
    {
        halfTileSize = Vector2.one * cellSize * 0.5f;
        AI_GridHalfSizeX = AI_GridSizeX / 2;
        AI_GridHalfSizeY = AI_GridSizeY / 2;

        CreateNodeGrid();
        UpdateNodePosition();
    }

    private void CreateNodeGrid()
    {
        _nodes = new AI_Node[AI_GridSizeX * AI_GridSizeY];
        AI_Node currentNode;
        for (int y = 0; y < AI_GridSizeY; y++)
        {
            for (int x = 0; x < AI_GridSizeX; x++)
            {
                currentNode = new AI_Node(true, Vector2.zero);
                currentNode.MatrixPos = new Vector2Int(x, y);
                _nodes[x + y * AI_GridSizeX] = currentNode;


                if (x > 0)
                {
                    _nodes[x - 1 + y * AI_GridSizeX].AddNeighbour(currentNode);
                    currentNode.AddNeighbour(_nodes[x - 1 + y * AI_GridSizeX]);
                }
                if (y > 0)
                {
                    _nodes[x + (y - 1) * AI_GridSizeX].AddNeighbour(currentNode);
                    currentNode.AddNeighbour(_nodes[x + (y - 1) * AI_GridSizeX]);
                }
            }
        }
    }

    Collider[] result = new Collider[1];

    private void UpdateNodePosition()
    {
        centerPos = gridCenter.position;
        centerPos.x /= cellSize;
        centerPos.x = Mathf.FloorToInt(centerPos.x) * cellSize;
        centerPos.y /= cellSize;
        centerPos.y = Mathf.FloorToInt(centerPos.y) * cellSize;

        AI_Node currentNode;
        for (int y = 0; y < AI_GridSizeY; y++)
        {
            for (int x = 0; x < AI_GridSizeX; x++)
            {
                currentNode = _nodes[x + y * AI_GridSizeX];
                currentNode.NodePos = centerPos + new Vector2((x + 1 - AI_GridHalfSizeX) * cellSize, (y + 1 - AI_GridHalfSizeY) * cellSize);
                if (Physics.OverlapSphereNonAlloc(NodeToWorldPos(currentNode.NodePos), obstacleDetectionRadius, result, obstacleDetectionLayer) > 0)
                { currentNode.IsValid = false; }
                else
                { currentNode.IsValid = true; }
            }
        }
    }

    private List<AI_Node> GetPathTo(AI_Node startNode, AI_Node endNode)
    {
        return AStar.Run(startNode, n => n == endNode,
            n => n.Neighbours.Where(thisNeighbour => thisNeighbour.IsValid).
            Select(neighbour => (neighbour, 1f)),
            n => Vector2.Distance(endNode.NodePos, n.NodePos), maxPathfindSteps);
    }

    public AI_Node GetNodeClosestTo(Vector2 worldPos)
    {
        var localPos = (worldPos - centerPos) + new Vector2(AI_GridHalfSizeX * cellSize, AI_GridHalfSizeY * cellSize);
        var xIndex = Mathf.Clamp(Mathf.RoundToInt(localPos.x / cellSize) - 1, 0, AI_GridSizeX - 1);
        var yIndex = Mathf.Clamp(Mathf.RoundToInt(localPos.y / cellSize) - 1, 0, AI_GridSizeY - 1);

        return _nodes[xIndex + yIndex * AI_GridSizeX];
    }

    public List<Vector3> GetPositionPathTo(Vector3 startPos, Vector3 endPos)
    {
        List<Vector3> path = new List<Vector3>();
        AI_Node startNode = GetNodeClosestTo(new Vector2(startPos.x, startPos.z)), endNode = GetNodeClosestTo(new Vector2(endPos.x, endPos.z));

        if (!endNode.IsValid)
            endNode = endNode.GetValidNeighbour() ?? endNode;

        var nodePath = GetPathTo(startNode, endNode);
        if (nodePath == null) return path;

        foreach (var node in nodePath)
        { path.Add(new Vector3(node.NodePos.x, 0, node.NodePos.y)); }

        return path;
    }

    private Vector3 NodeToWorldPos(Vector2 nodePos)
    {
        return new Vector3(nodePos.x, 0, nodePos.y);
    }

    private void OnDrawGizmos()
    {
        if (!drawGizmos) return;
        if (_nodes == null) return;

        foreach (var node in _nodes)
        {
            Gizmos.color = node.IsValid ? Color.white : Color.red;
            Gizmos.DrawSphere(NodeToWorldPos(node.NodePos), 0.1f);
            Gizmos.color = Color.green;
            Gizmos.DrawWireSphere(NodeToWorldPos(node.NodePos), 0.5f);
        }
    }
}
