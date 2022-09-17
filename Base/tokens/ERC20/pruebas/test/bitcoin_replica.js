const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");
const { expect } = require("chai");

describe("Bitcoin Replica Contract", function () {
	async function deployTokenFixture() {
		const Token = await ethers.getContractFactory("Bitcoin_Replica");
		const [owner, addr1, addr2] = await ethers.getSigners();

		const Bitcoin_Replica = await Token.deploy();

		await Bitcoin_Replica.deployed();

		// Nos da los valores necesarios para el resto de los tests
		return {Token, owner, addr1, addr2, Bitcoin_Replica};
	}
	describe("Deployment", function() {
		it("Should show 0 total supply and 0 assigned to owner", async function () {	
			const { Bitcoin_Replica, owner } = await loadFixture(deployTokenFixture);

			const ownerBalance = await Bitcoin_Replica.balanceOf(owner.address);
			expect(await Bitcoin_Replica.totalSupply()).to.equal(ownerBalance);
		});

		it("Should allow to mine the first block after deployment", async function() {
			const { Bitcoin_Replica, owner } = await loadFixture(deployTokenFixture);

			await expect(Bitcoin_Replica.mine(owner.address).to.changeTokenBalance(Bitcoin_Replica, owner, (50*10**18)));

		});

	});

	describe("Transactions", function() {
		it("Should be able to transfer mined tokens", async function() {
			const { Bitcoin_Replica, owner, addr1 } = await loadFixture(deployTokenFixture);

			await expect(Bitcoin_Replica.transfer(addr1.address, 50).to.changeTokenBalances(Bitcoin_Replica, [owner, addr1], [-50, 50]));
		});
	});
	
});

