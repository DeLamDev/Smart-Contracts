const { loadFixture, time } = require("@nomicfoundation/hardhat-network-helpers");
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

			await expect(Bitcoin_Replica.mine(owner.address)).to.changeTokenBalance(Bitcoin_Replica, owner, (50*10**18).toString());

		});

	});

	describe("Transactions", function() {
		it("Should be able to transfer mined tokens", async function() {
			const { Bitcoin_Replica, owner, addr1 } = await loadFixture(deployTokenFixture);

			await expect(Bitcoin_Replica.mine(owner.address)).to.changeTokenBalance(Bitcoin_Replica, owner, (50*10**18).toString());
			await expect(Bitcoin_Replica.transfer(addr1.address, (50*10**18).toString())).to.changeTokenBalances(Bitcoin_Replica, [owner, addr1], [(-(50*10**18)).toString(), (50*10**18).toString()]);

		});
		it("Should mine until the fist 10 blocks", async function() {
			const { Bitcoin_Replica, owner } = await loadFixture(deployTokenFixture);
			
			const initial_time = await Bitcoin_Replica.genesis();
			const ten_min = 600;
			let counter = initial_time;
			for (let i=1; i<=10; i++) {
				await expect(Bitcoin_Replica.mine(owner.address));
				counter = Number(counter) + ten_min;
				await time.increaseTo(counter);
			};
		});
		it("Should replicate the whole mining process", async function() {
			const { Bitcoin_Replica, owner } = await loadFixture(deployTokenFixture);

			const initial_time = await Bitcoin_Replica.genesis();
			const ten_min = 600;
			let counter = initial_time;
			while (await Bitcoin_Replica.current_reward() != 0) {
				await expect(Bitcoin_Replica.mining_test(owner.address));
				block = await Bitcoin_Replica.next_block();
				counter = Number(counter) + (ten_min * block);
				await time.increaseTo(counter);
			}
		})
	});
	
});
