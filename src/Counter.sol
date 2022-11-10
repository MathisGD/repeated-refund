// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
    error No();

    uint256 private number = 2;

    function set() public {
        number = 1;
    }

    function setAndRevert() public {
        number = 0;
        revert No();
    }
}

contract CounterTest {
    Counter private counter;

    uint256 a;

    function setUp() public {
        counter = new Counter();
    }

    function test() public {
        assembly {
            mstore(0xfff, 5)
        }

        Counter counterStack = counter;

        counterStack.set();

        uint256 i = 100;

        while (i-- >= 2) {
            try counterStack.setAndRevert() {} catch {}
        }
    }
}
