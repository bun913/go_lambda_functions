package main

/*
	This is Intitial Codes
	Please be coding on /app/ dir
	See Examples below
	https://github.com/aws/aws-lambda-go/tree/main/events
*/

import (
	"context"
	"fmt"

	"github.com/aws/aws-lambda-go/lambda"
)

func HandleRequest(ctx context.Context) (string, error) {
	fmt.Print("Hello!!")
	return fmt.Sprintf("Hello Lambda!!"), nil
}

func main() {
	lambda.Start(HandleRequest)
}
