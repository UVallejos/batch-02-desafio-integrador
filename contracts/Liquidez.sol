// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol";
import {IUniSwapV2Router02} from "./Interfaces.sol";
import {IUniswapV2Factory} from "./Interfaces.sol";

contract LiquidityProvider {
    address routerAddress = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    IUniSwapV2Router02 router = IUniSwapV2Router02(routerAddress);

    address factoryAddress = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;
    IUniswapV2Factory factory = IUniswapV2Factory(factoryAddress);

    address bbtkn = 0x9D0811F7753e6fB442c57d54A4E82E8Fb406a0dB;
    address usdc = 0xEfB83Efa68177627E1191c2391A9E04cF9B4fe59;

    IERC20Upgradeable tokenBTKN = IERC20Upgradeable(bbtkn);
    IERC20 tokenUSDC = IERC20(usdc);

    event LiquidityAddres(
        uint256 amountA,
        uint256 amountB,
        uint256 amountLpTokens
    );

    function addLiquidity(
        address _tokenBTKN,
        address _tokenUSDC,
        uint _amountADesired,
        uint _amountBDesired,
        uint _amountAMin,
        uint _amountBMin,
        address _to,
        uint _deadline
    ) public {

        uint256 amountA;
        uint256 amountB;
        uint256 amountLP;
        (amountA, amountB, amountLP) = router.addLiquidity(
            _tokenBTKN,
            _tokenUSDC,
            _amountADesired,
            _amountBDesired,
            _amountAMin,
            _amountBMin,
            _to,
            _deadline
        );

        emit LiquidityAddres(amountA, amountB, amountLP);
    }

    function getPair(
        address _tokenUSDCBTKN,
        address _tokenUSDC
    ) public view returns (address) {
        return factory.getPair(_tokenUSDCBTKN, _tokenUSDC);
    }
}