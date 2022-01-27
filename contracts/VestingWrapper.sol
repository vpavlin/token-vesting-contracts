// contracts/TokenVesting.sol
// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.11;

import "./TokenVesting.sol";

/**
 * @title Token Vesting Wrapper
 */
contract VestingWrapper is TokenVesting {
    enum VestingType {
        Presale,
        Team,
        Marketing,
//        Ecosystem,
        Staking
    }

    constructor(address _token) TokenVesting(_token) {

    }

    function newVesting(VestingType _type, address _beneficiary, uint _amount, uint _start) public onlyOwner {
        if(_type == VestingType.Presale) {
            newPresaleVesting(_beneficiary, _amount, _start);
        } else if (_type == VestingType.Team) {
            newTeamVesting(_beneficiary, _amount, _start);
        }
    }

    function newBulkVesting(
        VestingType[] memory _types,
        address[] memory _beneficiaries,
        uint[] memory _amounts,
        uint _start
    ) public onlyOwner {
        require(_types.length == _beneficiaries.length && _types.length == _amounts.length, "Corrupted input data");

        for(uint i=0; i < _types.length; i++) {
            newVesting(_types[i], _beneficiaries[i], _amounts[i], _start);
        }
    }

    function newPresaleVesting(address _beneficiary, uint _amount, uint _start) internal {
        uint _cliff = 365 days / 4;
        uint _duration = 365 days;
        uint _slicePeriodSeconds = 365 days / 12; //Monthly release
        uint __start = _start;
        if (__start == 0) {
            __start = block.timestamp;
        }
        bool _revocable = false;
        
        createVestingSchedule(
                _beneficiary,
                _start,
                _cliff,
                _duration,
                _slicePeriodSeconds,
                _revocable,
                _amount
            );
    }

    function newTeamVesting(address _beneficiary, uint _amount, uint _start) internal {
        uint _cliff = 3 * 365 days;
        uint _duration = 365 days / 12 * 20; //20 Months to get 5% a month
        uint _slicePeriodSeconds = 365 days / 12; //Monthly release
        uint __start = _start;
        if (__start == 0) {
            __start = block.timestamp;
        }
        bool _revocable = false;
        
        createVestingSchedule(
                _beneficiary,
                _start,
                _cliff,
                _duration,
                _slicePeriodSeconds,
                _revocable,
                _amount
            );
    }

    function newMarketingVesting(address _beneficiary, uint _amount, uint _start) internal {
        uint _cliff = 0;
        uint  _duration = 365 days / 12 * 20; //20 Months to get 5% a month
        uint _slicePeriodSeconds = 365 days / 12; //Monthly release
        uint __start = _start;
        if (__start == 0) {
            __start = block.timestamp;
        }
        bool _revocable = false;
        
        createVestingSchedule(
                _beneficiary,
                _start,
                _cliff,
                _duration,
                _slicePeriodSeconds,
                _revocable,
                _amount
            );
    }

    function newEcosystemVesting(address _beneficiary, uint _amount, uint _start) internal {
        uint _cliff = 0;
        uint _duration = 365 days / 12 * 20; //20 Months to get 5% a month
        uint _slicePeriodSeconds = 365 days / 12; //Monthly release
        uint __start = _start;
        if (__start == 0) {
            __start = block.timestamp;
        }
        bool _revocable = false;
        
        createVestingSchedule(
                _beneficiary,
                _start,
                _cliff,
                _duration,
                _slicePeriodSeconds,
                _revocable,
                _amount
            );
    }

}