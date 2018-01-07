var Splitter = artifacts.require("./Splitter.sol");

contract("Splitter", function(accounts) {
	var splitContract;
	var owner = accounts[0];
	var sender = accounts[1];
	var receiver1 = accounts[2];
	var receiver2 = accounts[3];
	var notInvited = accounts[4];	

	beforeEach(function(){
		return Splitter.new({from: owner})
		.then(function(instance){
			splitContract = instance;
		});
	});

	//constructor 
	it("should be owned by owner", function(){
		return splitContract.owner()
		.then(function(_actualOwner){
			assert.strictEqual(_actualOwner, owner,"contract is not owned by owner"); 		
		});
	});
});