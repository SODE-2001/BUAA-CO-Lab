#include<stdio.h>
int a[10][10],n,m;
int x1,y1,x2,y2,ans;
void dfs(int x,int y){
	if(x==x2&&y==y2){
		ans++;
	}
	else{
		if(x>0&&!a[x-1][y]){
			a[x-1][y]=1;
			dfs(x-1,y);
			a[x-1][y]=0;
		}
		if(y>0&&!a[x][y-1]){
			a[x][y-1]=1;
			dfs(x,y-1);
			a[x][y-1]=0;
		}
		if(x<n-1&&!a[x+1][y]){
			a[x+1][y]=1;
			dfs(x+1,y);
			a[x+1][y]=0;
		}
		if(y<m-1&&!a[x][y+1]){
			a[x][y+1]=1;
			dfs(x,y+1);
			a[x][y+1]=0;
		}
	}
	return ;
}
int main(){
	scanf("%d%d",&n,&m);
	int i,j;
	for(i=0;i<n;i++){
		for(j=0;j<m;j++){
			scanf("%d",&a[i][j]);
		}
	}
	scanf("%d%d",&x1,&y1);
	x1--; y1--;
	scanf("%d%d",&x2,&y2);
	x2--; y2--;
	a[x1][y1]=1;
	dfs(x1,y1);
	printf("%d",ans);
	return 0;
}
