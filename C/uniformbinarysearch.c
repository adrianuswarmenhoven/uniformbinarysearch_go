#define LOG_N 4 //2^10 where 10 is length of array

static int delta[LOG_N];

void make_delta(int N)
{
    int power = 1;
    int i = 0;
    do {
        int half = power;
        power <<= 1;
        delta[i] = (N + half) / power;
    } while (delta[i++] != 0);
}

int unisearch(int *a, int key)
{
    int i = delta[0]-1;  /* midpoint of array */
    int d = 0;

    while (1) {

        if (key == a[i]) {
            return i;
        } else if (delta[d] == 0) {
            return -1;
        } else {
            if (key < a[i]) {
                i -= delta[++d];
            } else {
                i += delta[++d];
            }
        }
    }
}

/* Example of use: */
#define N 10
int main(void)
{
    int i, a[N] = {1,3,5,6,7,9,14,15,17,19};
    make_delta(N);
    for (i=0; i < 20; ++i)
      printf("%d is at index %d\n", i, unisearch(a, i));
    return 0;
}
