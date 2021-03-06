# Goで作るLambda関数用のリポジトリ

## 構成

WIP: 別途構成図を作成する

## やること

- TerraformでAWSの各種リソースを作成(`infra/` ディレクトリ配下)
  - EC2その他のリソース
    - ↑念の為SessionManagerで接続できるようにしている
  - Lambda関数の初期構築
    - Lambda関数のコードやIAMロールなど
    - アプリコードの変更に伴う自動デプロイなどは後述
- GoでLambda各種Lambda関数を組む
  - 開発環境は `sam-cli` を利用する
  - `main` ブランチにマージされたタイミングでデプロイ用のワークフロー作動
    - GithubActionsでデプロイを行う

## 事前準備

WIP: githubactions によるlambda関数の自動デプロイを実装するまでは以下のように `go build` したものが `infra/modules/lambda/functions/` に `main` というファイル名で出力されている必要がある。

## 関数群

### EC2の自動停止

基本的に[踏み台はFargate等で作成した方がよいと考えています](https://zenn.dev/bun913/articles/aws-bastion-fargate-and-ec2)が、利便性のためにEC2を立てた方が良いこともあると思います。
（サクッとローカルのDBクライアントで調査ができる環境を立てたいなど）

EC2はよく停止死忘れることがあるため、踏み台を自動で指定した時間に停止できるようにLambda関数を作成。
(インスタンススケジューラーを利用しても良いのですが、そこまで難しいスケジュールではないのでLambdaで簡潔に作成)
