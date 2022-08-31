// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import {DSTestPlus} from "solmate/test/utils/DSTestPlus.sol";

import {LibGOO} from "../src/LibGOO.sol";

contract LibGOOTest is DSTestPlus {
    function testGOOBalanceMultiple() public {
        assertEq(LibGOO.computeGOOBalance(1, 1e18, 1e18), 2.25e18);
        assertEq(LibGOO.computeGOOBalance(2, 1e18, 1e18), 2.914213562373095048e18);
        assertEq(LibGOO.computeGOOBalance(3, 1e18, 1e18), 3.482050807568877293e18);

        assertEq(LibGOO.computeGOOBalance(10, 1e18, 1e18), 6.662277660168379331e18);

        assertEq(LibGOO.computeGOOBalance(100, 1e18, 1e18), 36e18);
    }

    function testGOOBalanceInitialBalance() public {
        assertEq(LibGOO.computeGOOBalance(1, 10e18, 1e18), 13.412277660168379331e18);
        assertEq(LibGOO.computeGOOBalance(2, 10e18, 1e18), 14.972135954999579392e18);
        assertEq(LibGOO.computeGOOBalance(3, 10e18, 1e18), 16.227225575051661134e18);

        assertEq(LibGOO.computeGOOBalance(10, 10e18, 1e18), 22.500000000000000000e18);

        assertEq(LibGOO.computeGOOBalance(100, 10e18, 1e18), 66.622776601683793319e18);
    }

    function testGOOBalanceTimeElapsed() public {
        assertEq(LibGOO.computeGOOBalance(1, 1e18, 10e18), 36e18);
        assertEq(LibGOO.computeGOOBalance(2, 1e18, 10e18), 65.142135623730950480e18);
        assertEq(LibGOO.computeGOOBalance(3, 1e18, 10e18), 93.320508075688772930e18);

        assertEq(LibGOO.computeGOOBalance(10, 1e18, 10e18), 282.622776601683793310e18);
        assertEq(LibGOO.computeGOOBalance(100, 1e18, 10e18), 2601e18);
    }

    function testGOOBalanceTimeElapsed2() public {
        assertEq(LibGOO.computeGOOBalance(1, 1e18, 1e18), 2.25e18);
        assertEq(LibGOO.computeGOOBalance(1, 1e18, 2e18), 4e18);
        assertEq(LibGOO.computeGOOBalance(1, 1e18, 3e18), 6.25e18);

        assertEq(LibGOO.computeGOOBalance(1, 1e18, 10e18), 36e18);

        assertEq(LibGOO.computeGOOBalance(1, 1e18, 100e18), 2601e18);
    }
}
