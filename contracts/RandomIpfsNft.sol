// SPDX-License-Identifier;
pragma solidity ^0.8.7;
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

//VRFCoordinatorV2Interface has `requesrRandomWords` function whch creata  `RandomNumber`.

//VRFConsumerBaseV2 has `reuestFullFillment`has exceute the function after the random number is generated.

/**
 * @read when we mint a NFT we will trigger chainlink `vrf` to get us a random number.
 * using that number we will get a ranodm NFT.
 * ANd Random NFT could be either PUG,SHIBA INU Or SAINT BERNARD.
 * And each one of them would have different `rarity`.
 * Like pug: rare, shibaInu : sortOfRare, st.Beanrad: common.
 *
 * Users have to pay for minting.
 * ANd owner can withdrawl the users fund. (like artist is getting paid for his art work).
 *
 * //requestNFt is same as `requestRandomNumberWords`.
 *
 * We use `immutable` when we have to go through`constructor` to add data.
 *we use `constant` when we have data in `stateVariable` which cant be change after deployed.
 */

contract RandomIpfsNft is VRFConsumerBaseV2 {
    //Chainlink State VRF Variables
    VRFCoordinatorV2Interface private immutable i_VrfCoordinatorV2;
    uint64 private immutable i_subscriptionId;
    bytes32 private immutable i_gasLane; //keyhash
    uint32 private immutable i_callbackGasLimit;
    uint16 private constant REQUEST_CONFIRMATIONS = 3;
    uint32 private constant NUM_WORDS = 1;

    //SINCE WE ARE INHERTING FROM `VRFConsumerBaseV2` WE HAVE TO MENTION IN CONSTRUCTOR.
    constructor(
        address VrfCoordinatorV2,
        uint64 subscriptionId,
        bytes32 gasLane,
        uint32 callbackGasLimit
    ) VRFConsumerBaseV2(VrfCoordinatorV2) {
        i_VrfCoordinator = VRFCoordinatorV2Interface(VrfCoordinatorV2);
        i_subscriptionId = subscriptionId;
        i_gasLane = gasLane;
        i_callbackGasLimit = callbackGasLimit;
    }
/** 
 * @read 
    *`requestNft` is `requesRanodmWords` function.
    *requestId = i_VrfCoordinator.requestRandomWords explanation-->
    *we are calling ` requestRandomWords` function from `i_VrfCoordinator` which is
    *`VRFCoordinatorV2Interface`. while filling all the required function things at `Constructor`.
    * and whatever `info` we get after Calling the `requestRandomWords` is gonnabe the `requestId`.
    */
    
    function requestNft() public returns (uint256 requestId) {
        requestId = i_VrfCoordinator.requestRandomWords(
            i_gasLane,
            i_subscriptionId,
            REQUEST_CONFIRMATIONS,
            i_callbackGasLimit,
            NUM_WORDS
        )
    }
}
