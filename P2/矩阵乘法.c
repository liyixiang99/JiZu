#include <stdio.h>
int main()
{
	int m;
	int aa[8][8],bb[8][8], cc[8][8];
	int i,j,k,sum;
	scanf("%d",&m);
	for (i=0;i<m;i++)
		for (j=0;j<m;j++)
			scanf("%d",&aa[i][j]);
	for (i=0;i<m;i++)
		for (j=0;j<m;j++)
			scanf("%d",&bb[i][j]);
	
	for (i=0;i<m;i++) {
		for (j=0;j<m;j++) {
			sum = 0;
			for (k=0;k<m;k++) {
				sum = sum + aa[i][k] * bb[k][j];
			}
			cc[i][j] = sum;
		}
	}
	
	for (i=0;i<m;i++) {
		for (j=0;j<m;j++) {
			printf("%d ", cc[i][j]);
		}
		printf("\n");
	}
	return 0;
}
