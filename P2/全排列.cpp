#include<stdio.h>
#include<stdlib.h>
int symbol[7],array[7];
int n;
void Fullarray(int index){
	int i;
	if(index>=n){
		for(i=0;i<n;i++){
			printf("%d",array[i]);
		}
		printf("\n");
	}
	for(i=0;i<n;i++){//µ¹Ðò£ºfor(i=n-1;i>=0;i--) 
		if(symbol[i]==0){
			array[index]=i+1;
			symbol[i]=1;
			Fullarray(index+1);
			symbol[i]=0;
		}
	}
} 
int main(){
	scanf("%d",&n);
	Fullarray(0);
	return 0;
}
