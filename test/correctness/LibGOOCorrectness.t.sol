// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {DSTestPlus} from "solmate/test/utils/DSTestPlus.sol";
import {Vm} from "forge-std/Vm.sol";
import {console} from "forge-std/console.sol";
import {LibGOO} from "../../src/LibGOO.sol";

contract LibGOOCorrectnessTest is DSTestPlus {
    using LibGOO for uint256;

    Vm internal immutable vm = Vm(HEVM_ADDRESS);

    function testFFILibGOOCorrectness(
        uint256 emissionMultiple,
        uint256 lastBalanceWad,
        uint256 timeElapsedWad
    ) public {
        emissionMultiple = bound(emissionMultiple, 0, 100);

        timeElapsedWad = bound(timeElapsedWad, 0, 7300 days * 1e18);

        lastBalanceWad = bound(lastBalanceWad, 0, 1e36);

        uint256 expectedBalance = calculateBalance(emissionMultiple, lastBalanceWad, timeElapsedWad);

        uint256 actualBalance = LibGOO.computeGOOBalance(emissionMultiple, lastBalanceWad, timeElapsedWad);

        if (expectedBalance < 0.0000000000001e18) return; // For really small balances we can't expect them to be equal.

        // Equal within 1 percent.
        assertRelApproxEq(actualBalance, expectedBalance, 0.01e18);
    }

    function calculateBalance(
        uint256 _emissionMultiple,
        uint256 _lastBalance,
        uint256 _timeElapsed
    ) private returns (uint256) {
        string[] memory inputs = new string[](8);
        inputs[0] = "python3";
        inputs[1] = "test/correctness/python/compute_goo_balance.py";
        inputs[2] = "--emission_multiple";
        inputs[3] = vm.toString(_emissionMultiple);
        inputs[4] = "--last_balance";
        inputs[5] = vm.toString(_lastBalance);
        inputs[6] = "--time_elapsed";
        inputs[7] = vm.toString(_timeElapsed);

        for (uint256 i = 0; i < 8; i++) {
            console.log(inputs[i]);
        }

        return abi.decode(vm.ffi(inputs), (uint256));
    }
}
