"""Generate a dated public-repository snapshot without external image services."""
import json
import os
import urllib.request
from datetime import datetime, timezone
from html import escape
from pathlib import Path

def collect(owner):
    repos = []
    for page in range(1, 101):
        req = urllib.request.Request(f'https://api.github.com/users/{owner}/repos?type=owner&per_page=100&page={page}', headers={'User-Agent':'profile-snapshot','Accept':'application/vnd.github+json'})
        if os.environ.get('GITHUB_TOKEN'):
            req.add_header('Authorization','Bearer '+os.environ['GITHUB_TOKEN'])
        with urllib.request.urlopen(req, timeout=30) as response:
            batch = json.load(response)
        repos.extend(r for r in batch if not r['fork'] and not r['private'])
        if len(batch)<100:
            break
    else:
        raise RuntimeError('Pagination limit reached; refusing a partial snapshot')
    return {'date':datetime.now(timezone.utc).strftime('%Y-%m-%d'),'repositories':len(repos),'stars':sum(r['stargazers_count'] for r in repos),'languages':len({r['language'] for r in repos if r['language']})}

def render(data):
    metrics=[('Public repositories',data['repositories']),('Repository stars',data['stars']),('Primary languages',data['languages'])]
    columns=''.join(f'<g transform="translate({32+i*284},65)"><text class="value" y="25">{v}</text><text class="label" y="57">{escape(label)}</text></g>' for i,(label,v) in enumerate(metrics))
    return f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 900 180" role="img" aria-labelledby="title desc">
<title id="title">Public GitHub repository snapshot</title>
<desc id="desc">{data['repositories']} public non-fork repositories, {data['stars']} repository stars, {data['languages']} distinct primary repository languages. Snapshot {data['date']} UTC.</desc>
<style>text{{font-family:system-ui,sans-serif}}.value{{fill:#67e8f9;font-size:36px;font-weight:700}}.label{{fill:#cbd5e1;font-size:15px}}</style>
<rect width="900" height="180" rx="18" fill="#0e1628"/>
<text x="32" y="30" fill="#a5b4fc" font-size="12">PUBLIC WORK / {data['date']} UTC</text>{columns}
<text x="32" y="158" fill="#94a3b8" font-size="12">Non-fork repositories · primary language per repository · weekly snapshot</text></svg>\n'''

if __name__=='__main__':
    destination=Path(os.environ.get('OUTPUT_DIR','dist'))
    snapshot=collect('Eskinder185')
    destination.mkdir(parents=True, exist_ok=True)
    (destination/'activity.svg').write_text(render(snapshot), encoding='utf-8')
    (destination/'activity.json').write_text(json.dumps(snapshot, indent=2)+'\n', encoding='utf-8')
    print(json.dumps(snapshot))
