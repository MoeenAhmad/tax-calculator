from web3 import Web3
from web3.middleware import geth_poa_middleware
from web3.contract import ConciseContract

w3 = Web3(Web3.HTTPProvider('HTTP://127.0.0.1:7545'))
w3.is_connected()
print(w3.is_connected())

print(w3.eth.get_block('latest'))


contract_abi = [

]
erc20_abi = [

]
erc20_token_address = "0xd9145CCE52D386f254917e481eB44e9943F39138"
contract_address = "0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8"


user_address = "0x7735F4c01Cb8298F2b221478EfbCB743CF75eC53"

erc20_contract = w3.eth.contract(address=erc20_token_address, abi=erc20_abi)
user_balance = erc20_contract.functions.balanceOf(user_address).call()
print(f"User Balance: {user_balance / 1e18} ETH")

# Load the contract
contract = w3.eth.contract(address=contract_address, abi=contract_abi)
contract_instance = ConciseContract(contract)

is_buy_transaction = True
transaction_amount = 1000000000000000000  # Amount in wei

if is_buy_transaction:
    tax_rate = contract_instance.buyTaxRate()
else:
    tax_rate = contract_instance.sellTaxRate()

tax_amount = (transaction_amount * tax_rate) // 10000
adjusted_transaction_amount = transaction_amount - tax_amount

print(f"Original Transaction Amount: {transaction_amount / 1e18} ETH")
print(f"Tax Amount: {tax_amount / 1e18} ETH")
print(f"Adjusted Transaction Amount: {adjusted_transaction_amount / 1e18} ETH")
