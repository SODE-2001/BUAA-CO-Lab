#include<stdio.h>
int n,arr[100],vis[100];
void dfs(int k){
	if(k==n){
		int i;
		for(i=0;i<n;i++) printf("%d ",arr[i]);
		printf("\n");
	}  
	else{
		int i;
		for(i=0;i<n;i++){
			if(!vis[i]){
				vis[i]=1;
				arr[k]=i+1;
				dfs(k+1);
				vis[i]=0;
			}
		}
	}
}
int main(){
	scanf("%d",&n);
	dfs(0);
	return 0;
}
