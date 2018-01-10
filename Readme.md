Small Project : Splitter

Splitter Contract Splits a sender's deposit equally between two receivers.

    Accepts deposits values >= 2
    Re-allocates 1 wei back to sender when odd values are sent
    Does not accept address(0) as a receivers' addresses
    Stores alloted funds in storage
    Recepients must claim their share
    Owner has sole access to suspend all functions or kill the contract

   Sender 
   		Sends a transaction with the funds to the split contract
   		gives split function the two receiver's addresses

   	receivers
   		send a transaction to the withdraw function
   		If they are owed, the contract transfers the funds to their addresses
   	
   	Owner
   		can pause/ un-pause the contract state
   		can kill contract ( when the contract is the 'paused' state)


