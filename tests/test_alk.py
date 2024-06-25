import unittest

from WAPB.parsed_AIk import AIk
from sage.all import *
from sage.crypto.boolean_function import BooleanFunction
from sage.rings.integer import Integer
import random


def partition(n):
    """
    Compute the partition of range(2^n) in slices of integers according to their hamming weight.

    For instance,
      > partition(4)
      {0: [0], 1: [1, 2, 4, 8], 2: [3, 5, 6, 9, 10, 12], 3: [7, 11, 13, 14], 4: [15]}


    Args:
        n (int): number of variables

    Returns:
        dict: dictionary P such that P[k] is the set of numbers x in range(2^n) such that hw(x)=k
    """
    P = {}
    for i in range(n + Integer(1)): P[i] = []
    for d in range(Integer(2) ** n): P[bin(d).count("1")].append(d)
    return P


class TestAIk(unittest.TestCase):

    def test_aik(self):
        k = 3
        vect = [Integer(random.randint(0, 1)) for _ in range(2 ** 3)]
        f = BooleanFunction(vect)
        res = AIk(f=f, k=k)
        self.assertEqual(res, 0)
