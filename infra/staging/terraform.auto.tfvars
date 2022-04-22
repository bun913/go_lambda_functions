vpc_cidr = "10.20.0.0/16"

private_subnets = [
  {
    "name" : "ec2_stop-go-private-a",
    "az" : "ap-northeast-1a",
    "cidr" : "10.20.10.0/24"
  },
  {
    "name" : "ec2_stop-go-private-c",
    "az" : "ap-northeast-1c",
    "cidr" : "10.20.11.0/24"
  },
]

vpc_endpoint = {
  "interface" : [
    # SSMでBastionに接続するため
    "com.amazonaws.ap-northeast-1.ec2messages",
    "com.amazonaws.ap-northeast-1.ssm",
    "com.amazonaws.ap-northeast-1.ssmmessages",
  ],
  "gateway" : [
    # yum経由での各種パッケージの取得に利用
    "com.amazonaws.ap-northeast-1.s3"
  ]
}
