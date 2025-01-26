using JuMP, CPLEX


function create_and_solve_model()

    #---------Model----------#
    model = Model(CPLEX.Optimizer)

    # Decision variables
    @variable(model, v_ikl[N, K, L])


end