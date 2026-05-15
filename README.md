# y-chiba1008-template-docker-image

## About
devcontainer開発環境用イメージ。
- ベースイメージ: mcr.microsoft.com/devcontainers/base:ubuntu
- mise, Gemini CLI インストール済み 

## Commands
```shell
# タグ設定
git tag <タグ名>
git push origin <タグ名>
```

## CI/CD
本リポジトリには下記のGitHub Actionsを設定している

### Docker Image Publish
Gitタグのpushを契機に、自動的にGHCRでイメージを公開する
- 対象のGitタグ: v* (v1.0.0など)
- イメージ名・タグ: ghcr.io/<GitHubユーザ名>/<リポジトリ名>:<タグ>
- latestタグを自動的に更新する

## Settings
### リポジトリ権限
GitHub Actionsの動作の為に権限を設定する。
- Settings > Actions > General
- Workflow permissions → "Read and write permissions" にチェックを入れる