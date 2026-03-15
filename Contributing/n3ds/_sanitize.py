import re, unicodedata, sys

s = sys.argv[1]
s = unicodedata.normalize('NFKD', s)
s = ''.join(c for c in s if not unicodedata.combining(c))
s = s.encode('ascii', 'ignore').decode()
s = re.sub(r'^0004[0-9A-Fa-f]{12}[-_ ]?', '', s)
m = re.search(r'\.[^.]+$', s)
ext = m.group(0) if m else ''
s = s[:m.start()] if m else s
s = re.sub(r'[-_ .]?[Ss]tandard$', '', s)
s = re.sub(r'[-_ .]?[Dd]ecrypted$', '', s)
s = re.sub(r'[-_ .]?[Pp]iratelegit$', '', s)
am = re.match(r'^(The|An|A) ', s, re.I)
if am:
    art = am.group(1)
    rest = s[am.end():]
    di = rest.find(' - ')
    s = rest[:di] + ', ' + art + ' - ' + rest[di+3:] if di >= 0 else rest + ', ' + art
s = s.replace("'", '')
s = re.sub(r'\([^)]*\)', '', s)
s = re.sub(r' *- *', '-', s)
s = s.replace(' ', '-')
s = re.sub(r'[^A-Za-z0-9-]+', '', s)
s = re.sub(r'-+', '-', s).strip('-').lower()
print(s + '.wav')
