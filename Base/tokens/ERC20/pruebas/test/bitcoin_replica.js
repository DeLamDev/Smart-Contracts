const { expect } = require("chai");

describe("Bitcoin Replica Contract", function () {
	it("Deployment should assing global variables", async function () {
		const [owner] = await ethers.getSigners();
		const Token = await ethers.getContractFactory("Bitcoin_Replica");
		const Bitcoin_Replica = await Token.deploy();
		const ownerBalance = await Bitcoin_Replica.balanceOf(owner.address);
		expect(await Bitcoin_Replica.totalSupply()).to.equal(ownerBalance);
	})
})
