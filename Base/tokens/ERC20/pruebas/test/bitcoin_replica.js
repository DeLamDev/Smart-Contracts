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
	it("Should show 0 total supply and 0 assigned to owner", async function () {	
		const { Bitcoin_Replica, owner } = await loadFixture(deployTokenFixture);

		const ownerBalance = await Bitcoin_Replica.balanceOf(owner.address);
		expect(await Bitcoin_Replica.totalSupply()).to.equal(ownerBalance);
	});

	it(":")
})

