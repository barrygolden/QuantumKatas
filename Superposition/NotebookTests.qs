namespace Quantum.Kata.Superposition {    
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Extensions.Convert;
    open Microsoft.Quantum.Extensions.Math;

    operation CheckTask1(solution : (Qubit[] => Unit)) : Unit {
            AssertEqualOnZeroState(1, solution, PlusState_Reference);
    }

    operation CheckTask2(solution : (Qubit[] => Unit)): Unit {
        AssertEqualOnZeroState(1, solution, MinusState_Reference);
    }

    operation CheckTask3(solution : ((Qubit[], Double) => Unit)) : Unit {
        // cross-test
        AssertEqualOnZeroState(1, solution(_, 0.0), ApplyToEachA(I, _));
        AssertEqualOnZeroState(1, solution(_, 0.5 * PI()), ApplyToEachA(X, _));
        AssertEqualOnZeroState(1, solution(_, 0.5 * PI()), ApplyToEachA(Y, _));
        AssertEqualOnZeroState(1, solution(_, 0.25 * PI()), PlusState_Reference);
        AssertEqualOnZeroState(1, solution(_, 0.75 * PI()), MinusState_Reference);

        for (i in 1 .. 36) {
            let alpha = ((2.0 * PI()) * ToDouble(i)) / 36.0;
            AssertEqualOnZeroState(1, solution(_, alpha), UnequalSuperposition_Reference(_, alpha));
        }
    }

    operation CheckTask4(solution : (Qubit[] => Unit)) : Unit {
        // We only check for 2 qubits.
        AssertEqualOnZeroState(2, solution, AllBasisVectors_TwoQubits_Reference);
    }

    operation CheckTask5(solution : (Qubit[] => Unit)) : Unit {
        // We only check for 2 qubits.
        AssertEqualOnZeroState(2, solution, AllBasisVectorsWithPhases_TwoQubits_Reference);
    }

}