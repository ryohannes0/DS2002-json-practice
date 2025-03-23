import json
import pandas as pd

with open('data/schacon.repos.json', 'r') as file:
    data = json.load(file)

repos_data = []
for repo in data:
    repo_info = {
        'name': repo.get('name'),
        'html_url': repo.get('html_url'),
        'updated_at': repo.get('updated_at'),
        'visibility': repo.get('visibility')
    }
    repos_data.append(repo_info)

df = pd.DataFrame(repos_data)

df.head().to_csv('chacon.csv', index=False)

print("Data exported to chacon.csv")
