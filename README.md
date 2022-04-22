# GoでEC2を停止するLambdaサンプル

## 構成

WIP: 別途構成図を作成する

## やること

- TerraformでAWSの各種リソースを作成(`infra/` ディレクトリ配下)
  - EC2その他のリソース
    - ↑念の為SessionManagerで接続できるようにしている
  - Lambda関数の初期構築
    - Lambda関数のコードやIAMロールなど
    - アプリコードの変更に伴う自動デプロイなどは後述
- GoでEC2を停止するコードを組む
  - 開発環境は `sam-cli` を利用する
  - `main` ブランチにマージされたタイミングでデプロイ用のワークフロー作動
    - GithubActionsでデプロイを行う

## やらないこと

- lambda用のコードを別リポジトリで管理すること