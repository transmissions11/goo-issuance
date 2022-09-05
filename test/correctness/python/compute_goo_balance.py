from eth_abi import encode_single
import math
import argparse

def compute_goo_balance(emission_multiple, last_balance, time_elapsed):
    t1 = math.sqrt(emission_multiple) * time_elapsed + 2 * math.sqrt(last_balance)
    final_amount = 0.25 * t1 * t1

    final_amount *= (10 ** 18)
    encode_and_print(final_amount)

def encode_and_print(price):
    enc = encode_single('uint256', int(price))
    ## append 0x for FFI parsing
    print("0x" + enc.hex())

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--emission_multiple", type=int)
    parser.add_argument("--last_balance", type=int)
    parser.add_argument("--time_elapsed", type=int)
    return parser.parse_args()

if __name__ == '__main__':
    args = parse_args()
    compute_goo_balance(
        args.emission_multiple
        , args.last_balance / (10 ** 18)
        , args.time_elapsed / (10 ** 18))