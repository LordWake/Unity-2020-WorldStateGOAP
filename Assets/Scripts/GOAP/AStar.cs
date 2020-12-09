using System.Collections.Generic;
using System;

public static class AStar
{
	public static List<Node> Run<Node>(
			Node start,
			Func<Node, bool> satisfies,
			Func<Node, IEnumerable<(Node, float)>> expand,
			Func<Node, float> heuristic,
			int maxSteps = 5000
		)
	{
		//Unchecked Nodes
		var open = new MinHeap<Node>(64);
		//Take the first node
		open.Push(start, 0);
		//Already check nodes
		var closed = new HashSet<Node>();

		//"Fathers" Dictionary. Key-> Son, Value->Father
		var parents = new Dictionary<Node, Node>();

		//Costs Dictionary, Key->Node, Value->Tentative cost to get there
		var costs = new Dictionary<Node, float>();
		costs[start] = 0;

		int watchdog = maxSteps;

		while (open.Count > 0 && watchdog > 0)//While we have nodes to check...
		{
			watchdog--;
			//Get the node with the shortest path
			var current = open.Pop();

			var currentCost = costs[current];

			if (satisfies(current))
				return ConstructPath(current, parents);

			closed.Add(current);

			foreach (var childPair in expand(current))
			{
				var child = childPair.Item1;
				var childCost = childPair.Item2;

				//If we have already check this node, we continue with the next one
				if (closed.Contains(child)) continue;

				var tentativeCost = currentCost + childCost;
				if (costs.ContainsKey(child) && tentativeCost > costs[child]) continue;

				parents[child] = current;

				costs[child] = tentativeCost;
				open.Push(child, tentativeCost + heuristic(child));
			}

		}

		return null;
	}

	private static List<Node> ConstructPath<Node>(Node end, Dictionary<Node, Node> parents)
	{
		//Builds the reverse path to destination

		var path = new List<Node>();
		path.Add(end);

		while (parents.ContainsKey(path[path.Count - 1]))
		{
			var lastNode = path[path.Count - 1];
			path.Add(parents[lastNode]);
		}

		path.Reverse();
		return path;
	}

}
