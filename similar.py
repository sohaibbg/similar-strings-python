import json
from strsimpy.normalized_levenshtein import NormalizedLevenshtein

normalized_levenshtein = NormalizedLevenshtein()
f = open('assets/stopList.json')
stopList = json.load(f)


def find_dups(l, comparator):
    def acc_compare(a):
        return a['acc']
    res = []
    for i, s1 in enumerate(l):
        for s2 in l[i+1:]:
            res.append(
                {'s1': s1, 's2': s2, 'acc': comparator(s1, s2)}
            )
            print('\r', 100*i/len(l), end='', flush=True)
    res.sort(key=acc_compare, reverse=True)
    return res


dups = find_dups(stopList[:5], normalized_levenshtein.distance)
with open('assets/dups.json', 'w') as f:
    json.dump(dups, f)
