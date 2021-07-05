/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kyuki <kyuki@student.42tokyo.jp>           +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/07/05 12:36:57 by kyuki             #+#    #+#             */
/*   Updated: 2021/07/05 12:36:58 by kyuki            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm.h"

#define RESET   "\033[0m"
#define RED     "\033[31m"
#define GREEN   "\033[32m"
#define BUFFER_SIZE 100000

#define OPEN_FILE "kyuki"

char *s1 = "Hello World\n";
char *s2 = "\0";
char *s3 = NULL;
char *s4 = "Jason Statham is an English actor. Typecast as the antihero, he is known for his action-thriller roles and portraying tough, irredeemable, and machiavellian characters. Born in Shirebrook, Derbyshire, he began practising kung fu, kickboxing and karate recreationally in his youth while working at local market stalls.\n";

void test_ft_write(int fd, char *s, int buf)
{
	ssize_t res_lib;
	ssize_t res_myf;
	int err;

	errno = 0;
	res_myf = ft_write(fd, s, buf);
	err = errno;
	res_lib = write(fd, s, buf);
	if (err == errno && res_myf == res_lib)
		printf("%s[OK]%s ", GREEN, RESET);
	else
		printf("%s[KO]%s ", RED, RESET);
}

void test_ft_strlen(char *s)
{
	int lib;
	int myf;

	myf = ft_strlen(s);
	lib = strlen(s);
	if (myf == lib)
		printf("%s[OK] %s", GREEN, RESET);
	else
		printf("%s[KO] %s", RED, RESET);
}

void test_ft_strcpy(char *s)
{
	char tmp1[BUFFER_SIZE];
	char tmp2[BUFFER_SIZE];
	char tmp3[BUFFER_SIZE];
	ft_strcpy(tmp1 ,s);
	strcpy(tmp2 ,s);
	if ((!strcmp(tmp1, tmp2)))
		printf("%s[OK]%s ", GREEN, RESET);
	else
		printf("%s[KO]%s ", RED, RESET);
	strcpy(tmp3, tmp2);
	strcpy(tmp2, tmp1);
	ft_strcpy(tmp1, tmp3);
	if (!strcmp(tmp1, tmp2))
		printf("%s[OK]%s ", GREEN, RESET);
	else
		printf("%s[KO]%s ", RED, RESET);
}

void test_ft_strcmp(char *str1, char *str2)
{
	int lib;
	int myf;

	myf = ft_strcmp(str1, str2);
	lib = strcmp(str1, str2);
	if (myf == lib)
		printf("%s[OK] %s", GREEN, RESET);
	else
		printf("%s[KO] %s", RED, RESET);
}

void test_ft_strdup(char *str1)
{
	char *lib;
	char *myf;

	myf = ft_strdup(str1);
	lib = strdup(str1);
	if (!strcmp(myf, lib))
		printf("%s[OK] %s", GREEN, RESET);
	else
		printf("%s[KO] %s", RED, RESET);
}

void test_ft_read(char *path, int size)
{
	char *res_lib;
	char *res_myf;
	int num_myf;
	int num_lib;
	int err;
	int fd;

	res_lib = calloc(1, sizeof(char) * BUFFER_SIZE + 1);
	res_myf = calloc(1, sizeof(char) * BUFFER_SIZE + 1);
	errno = 0;
	if (size == 42)
		fd = 42;
	else
		fd = open(path, O_RDONLY);
	num_myf = ft_read(fd, res_myf, size);
	close(fd);

	err = errno;
	if (size == 42)
		fd = 42;
	else
		fd = open(path, O_RDONLY);
	num_lib = read(fd, res_lib, size);
	close(fd);
	if (err == errno && !strcmp(res_myf, res_lib) && num_myf == num_lib)
		printf("%s[OK]%s ", GREEN, RESET);
	else
		printf("%s[KO]%s ", RED, RESET);
}



int main()
{
	int fd;

	printf("\n================================\n");
	printf("========== FT_WRITE ============\n");
	printf("================================\n");
	test_ft_write(1, s1, 12);
	test_ft_write(1, s1, 0);
	test_ft_write(1, s1, -12);
	test_ft_write(5, s1, 12);
	test_ft_write(0, s1, 12);
	fd = open(OPEN_FILE, O_WRONLY);
	test_ft_write(fd, s1, 12);
	test_ft_write(1, s2, 1);
	test_ft_write(1, s2, 12);
	test_ft_write(1, s3, 12);
	close(fd);

	puts("\n");
	printf("================================\n");
	printf("========== FT_STRLEN ===========\n");
	printf("================================\n");
	test_ft_strlen(s1);
	test_ft_strlen(s2);
	test_ft_strlen(s4);
	test_ft_strlen("aa\0bb");
	puts("\n");
	printf("\n================================\n");
	printf("========== FT_STRCPY ===========\n");
	printf("================================\n");
	test_ft_strcpy(s1);
	test_ft_strcpy(s2);
	test_ft_strcpy(s4);
	test_ft_strcpy("aa\0bb");
	puts("\n");
	printf("================================\n");
	printf("========== FT_STRCMP ===========\n");
	printf("================================\n");
	test_ft_strcmp("abc", "abc");
	test_ft_strcmp("abz", "abc");
	test_ft_strcmp("abcd", "abc");
	test_ft_strcmp("abc", "abcd");
	test_ft_strcmp("abc", "abz");
	test_ft_strcmp("abcdefghijk", "abcdefghijkk");
	test_ft_strcmp("a", "ab");
	test_ft_strcmp("", "");
	test_ft_strcmp("the\0hidden", "the\0hidden");
	test_ft_strcmp("\xff", "\xff\xff");
	test_ft_strcmp("\xff", "\xff\xfe");
	test_ft_strcmp("\x02", "\x02\x01");
	puts("\n");
	printf("================================\n");
	printf("========== FT_STRDUP ===========\n");
	printf("================================\n");
	test_ft_strdup(s1);
	test_ft_strdup(s2);
	test_ft_strdup(s4);
	puts("\n");
	printf("================================\n");
	printf("========== FT_READ =============\n");
	printf("================================\n");
	test_ft_read("./test.txt", 30);
	test_ft_read("fault", 30);
	test_ft_read("test.txt", -100);
	test_ft_read(NULL, 5);
	test_ft_read("./test.txt", 100);
	test_ft_read("./test.txt", 42);
	test_ft_read("./main.c", 100000);
	puts("\n");
	return 0;
}
