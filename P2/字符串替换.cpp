#include<stdio.h>
#include<string.h>
int main()
{
	int n1,n2,n3;
	char a[100],b[100],c[100];
	scanf("%d\n",&n1);
	scanf("%d\n",&n2);
	scanf("%d\n",&n3);
	int m = 0;
	for(m=0;m<n1;m++)
		scanf("%c",&a[m]);
	int k = 0;
	for(k=0;k<n2;k++)
		scanf("%c",&b[k]);
	int l = 0;
	for(l=0;l<n3;l++)
		scanf("%c",&c[l]);
	int i = 0;
	int j = 0;
	while(i<n1){
		int flag = 1;
		for(j=0;j<n2;j++){
			if(a[i+j]!=b[j]){
				flag = 0;
				break;
			}
		}
		if(flag == 1){
			printf("%s",c);
			i = i+n2;
		}
		else{
			printf("%c",a[i]);
			i++;
		}
	}	
	return 0;
}
