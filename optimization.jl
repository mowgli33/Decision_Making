using JuMP, CPLEX, CSV, DataFrames

input_directory = "data/dataset_4/"

X = CSV.read(joinpath(input_directory, "X.csv"), DataFrame, header=false)
Y = CSV.read(joinpath(input_directory, "Y.csv"), DataFrame, header=false)

N = [k for k in 1:size(X, 2)]   #nb of criterions
J = [k for k in 1:size(X, 1)]   #nb of samples
println(N)


function create_and_solve_model(X,Y)

    #---------Model----------#
    model = Model(CPLEX.Optimizer)

    # Decision variables
    @variable(model, 1>=v_ji[J, N]>=0)  #for j pairs and i criterions

    @variable(model, epsilon[J]>=0)     #for j pairs

    #constraints

    @constraint(model, c1[j in J],
    sum(v_ji[j, n] * X[j, n] for n in N) - sum(v_ji[j, n] * Y[j, n] for n in N) + epsilon[j] >= 0
)


    @objective(model, Min, sum(epsilon[:]))
    optimize!(model)
    println(solution_summary(model))

end

create_and_solve_model(X,Y)