using System;
using System.Collections.Generic;
using System.Linq;

public static class GOAP
{
    public static List<GoapAction<Model>> Run<Model>(Model initalState,
                                                 Func<Model, bool> satisfies,
                                                 List<GoapAction<Model>> actions,
                                                 Func<Model, float> heuristic,
                                                 int maxSteps = 5000)
    {
		(Model initalState, GoapAction<Model>) fakeInitialState = (initalState, default(GoapAction<Model>));

        Func<(Model, GoapAction<Model>), bool> fakeSatisfies = t =>     {return satisfies(t.Item1);};
        Func<(Model, GoapAction<Model>), float> fakeHeuristic = t =>    {return heuristic(t.Item1);};

        Func<(Model, GoapAction<Model>), IEnumerable<((Model, GoapAction<Model>), float)>> expand = state =>
        {
			List<((Model, GoapAction<Model>), float)> list = new List<((Model, GoapAction<Model>), float)>();
            foreach (var action in actions)
            {
                if (action.condition(state.Item1))
                    list.Add(((action.effect(state.Item1), action), action.cost));
            }

            return list;
        };

		List<(Model, GoapAction<Model>)> result = AStar.Run(fakeInitialState, fakeSatisfies, expand, fakeHeuristic, maxSteps);
        if (result == null)
            return null;
        
        return result.Skip(1).Select(t => t.Item2).ToList();
    }
}

