#include<stdio.h>
int a[1010];
int main(){
	int n;
	scanf("%d",&n);
	a[0]=1;
	int end=0;
	int i,j;
	for(i=2;i<=n;i++){
		int pre=0;
		for(j=0;j<=end;j++){
			a[j]=a[j]*i;
			a[j]=a[j]+pre;
			pre=a[j]/10;
			a[j]=a[j]%10;
			if(j==end&&pre>0) end=end+1;
		} 
	}
	for(i=end;i>=0;i--){
		printf("%d",a[i]);
	}
	return 0;
}
