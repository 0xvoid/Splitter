pragma solidity ^0.4.8;

contract Splitter {
 
    address public owner;
    bool    public isRunning;
    mapping(address => uint) public  allotment;
    
    modifier onlyWhenRunning {
        require (isRunning == true);
        _;
    }
    
     modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
        
    event LogSplitAllocation(address indexed firstReceiver, address indexed secondReceiver, address sender, uint splitAmount);
    event LogWithdrawal(address withdrawer, uint withdrawnAmount);
    
     function Splitter() 
        public
    {
        owner       = msg.sender;
        isRunning   = true;
    }
    
    function split( address firstReceiver, address secondReceiver )
        public
        payable
        onlyWhenRunning
        returns (bool success)
    {       
        require(msg.value > 1);
        require(msg.sender != 0);
        require(firstReceiver != 0 );
        require(secondReceiver != 0);        
        
        uint amountToSplit = msg.value;
        uint splitAmount = 0;        
        
        if (amountToSplit % 2 == 0) { 
           splitAmount = amountToSplit/2;           
        }  else {
           splitAmount = (amountToSplit - 1) /2;
           allotment[msg.sender] += 1;           
        }
        
        allotment[firstReceiver]  += splitAmount;
        allotment[secondReceiver] += splitAmount;                
        LogSplitAllocation (firstReceiver, secondReceiver, msg.sender, splitAmount);
               
        return true;
    }
    
     function withdraw()
        public
        onlyWhenRunning
        returns (bool success)
    {
        require(allotment[msg.sender] != 0);
        uint amountToWithdraw = allotment[msg.sender];
       
        allotment[msg.sender] = 0;
        msg.sender.transfer(amountToWithdraw);
      
        LogWithdrawal(msg.sender, amountToWithdraw);
       
        return true;
    }
    
    
    function toggleRunning(bool _onOff)
        public
        onlyOwner
        returns (bool value)
    {
        return isRunning = _onOff;
    }
    
    function killMe()
        public
        onlyOwner 
    {
        selfdestruct(owner);
    }

   
    function () public { revert();}
        
}
