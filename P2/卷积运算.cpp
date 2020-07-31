#include<stdio.h>
int main() 
{
	int he[100];
	int juan[100];
	int m1, m2, n1, n2;
	scanf("%d %d %d %d", &m1, &n1, &m2, &n2);
	int i, j, k, l, sum;
	for (i = 0; i < m1*n1; i++) {
		scanf("%d", &juan[i]);
	}	
	for (i = 0; i < m2*n2; i++) {
		scanf("%d", &he[i]);
	}	
	for (i = 0; i < m1 - m2 + 1; i++) {
		for (j = 0; j < n1 - n2 + 1; j++) {
			sum = 0;
			for (k = 0; k < m2; k++) {
				for (l = 0; l < n2; l++) {
					//sum += juan[n1*(k+i)+l+j] * he[n2*k+l];
					//sum += juan[i+k][j+l]*he[k][l];
				}
			}
			printf("%d ", sum);
		}
		printf("\n");
	}
	return 0;
}	
