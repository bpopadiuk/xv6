
_time:     file format elf32-i386


Disassembly of section .text:

00000000 <print_ticks_as_seconds>:
#include "types.h"
#include "user.h"

void
print_ticks_as_seconds(uint milliseconds)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
  uint integer_part = milliseconds / 1000;
   6:	8b 45 08             	mov    0x8(%ebp),%eax
   9:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
   e:	f7 e2                	mul    %edx
  10:	89 d0                	mov    %edx,%eax
  12:	c1 e8 06             	shr    $0x6,%eax
  15:	89 45 f4             	mov    %eax,-0xc(%ebp)
  uint fractional_part = milliseconds % 1000;
  18:	8b 4d 08             	mov    0x8(%ebp),%ecx
  1b:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
  20:	89 c8                	mov    %ecx,%eax
  22:	f7 e2                	mul    %edx
  24:	89 d0                	mov    %edx,%eax
  26:	c1 e8 06             	shr    $0x6,%eax
  29:	69 c0 e8 03 00 00    	imul   $0x3e8,%eax,%eax
  2f:	29 c1                	sub    %eax,%ecx
  31:	89 c8                	mov    %ecx,%eax
  33:	89 45 f0             	mov    %eax,-0x10(%ebp)
  printf(1, "%d.", integer_part);
  36:	83 ec 04             	sub    $0x4,%esp
  39:	ff 75 f4             	pushl  -0xc(%ebp)
  3c:	68 48 0a 00 00       	push   $0xa48
  41:	6a 01                	push   $0x1
  43:	e8 49 06 00 00       	call   691 <printf>
  48:	83 c4 10             	add    $0x10,%esp
  if(fractional_part < 10) 
  4b:	83 7d f0 09          	cmpl   $0x9,-0x10(%ebp)
  4f:	77 14                	ja     65 <print_ticks_as_seconds+0x65>
    printf(1, "00");
  51:	83 ec 08             	sub    $0x8,%esp
  54:	68 4c 0a 00 00       	push   $0xa4c
  59:	6a 01                	push   $0x1
  5b:	e8 31 06 00 00       	call   691 <printf>
  60:	83 c4 10             	add    $0x10,%esp
  63:	eb 18                	jmp    7d <print_ticks_as_seconds+0x7d>
  else if(fractional_part < 100)
  65:	83 7d f0 63          	cmpl   $0x63,-0x10(%ebp)
  69:	77 12                	ja     7d <print_ticks_as_seconds+0x7d>
    printf(1, "0");
  6b:	83 ec 08             	sub    $0x8,%esp
  6e:	68 4f 0a 00 00       	push   $0xa4f
  73:	6a 01                	push   $0x1
  75:	e8 17 06 00 00       	call   691 <printf>
  7a:	83 c4 10             	add    $0x10,%esp
  printf(1, "%d", fractional_part);
  7d:	83 ec 04             	sub    $0x4,%esp
  80:	ff 75 f0             	pushl  -0x10(%ebp)
  83:	68 51 0a 00 00       	push   $0xa51
  88:	6a 01                	push   $0x1
  8a:	e8 02 06 00 00       	call   691 <printf>
  8f:	83 c4 10             	add    $0x10,%esp
}
  92:	90                   	nop
  93:	c9                   	leave  
  94:	c3                   	ret    

00000095 <main>:

int
main(int argc, char *argv[])
{
  95:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  99:	83 e4 f0             	and    $0xfffffff0,%esp
  9c:	ff 71 fc             	pushl  -0x4(%ecx)
  9f:	55                   	push   %ebp
  a0:	89 e5                	mov    %esp,%ebp
  a2:	53                   	push   %ebx
  a3:	51                   	push   %ecx
  a4:	83 ec 10             	sub    $0x10,%esp
  a7:	89 cb                	mov    %ecx,%ebx
    int ret;
    uint t1, t2;
    uint running_time;

    if(argc < 2) {
  a9:	83 3b 01             	cmpl   $0x1,(%ebx)
  ac:	7f 3e                	jg     ec <main+0x57>
        running_time = 0;
  ae:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
        printf(1, "ran in ");
  b5:	83 ec 08             	sub    $0x8,%esp
  b8:	68 54 0a 00 00       	push   $0xa54
  bd:	6a 01                	push   $0x1
  bf:	e8 cd 05 00 00       	call   691 <printf>
  c4:	83 c4 10             	add    $0x10,%esp
        print_ticks_as_seconds(running_time);
  c7:	83 ec 0c             	sub    $0xc,%esp
  ca:	ff 75 e8             	pushl  -0x18(%ebp)
  cd:	e8 2e ff ff ff       	call   0 <print_ticks_as_seconds>
  d2:	83 c4 10             	add    $0x10,%esp
        printf(1, " seconds.\n");
  d5:	83 ec 08             	sub    $0x8,%esp
  d8:	68 5c 0a 00 00       	push   $0xa5c
  dd:	6a 01                	push   $0x1
  df:	e8 ad 05 00 00       	call   691 <printf>
  e4:	83 c4 10             	add    $0x10,%esp
        exit();
  e7:	e8 ee 03 00 00       	call   4da <exit>
    }

    ret = fork();
  ec:	e8 e1 03 00 00       	call   4d2 <fork>
  f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(ret == 0) {
  f4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  f8:	75 3b                	jne    135 <main+0xa0>
        exec(argv[1], &argv[1]);
  fa:	8b 43 04             	mov    0x4(%ebx),%eax
  fd:	8d 50 04             	lea    0x4(%eax),%edx
 100:	8b 43 04             	mov    0x4(%ebx),%eax
 103:	83 c0 04             	add    $0x4,%eax
 106:	8b 00                	mov    (%eax),%eax
 108:	83 ec 08             	sub    $0x8,%esp
 10b:	52                   	push   %edx
 10c:	50                   	push   %eax
 10d:	e8 00 04 00 00       	call   512 <exec>
 112:	83 c4 10             	add    $0x10,%esp
        printf(2, "ERROR: exec failed to execute %s\n", argv[1]);
 115:	8b 43 04             	mov    0x4(%ebx),%eax
 118:	83 c0 04             	add    $0x4,%eax
 11b:	8b 00                	mov    (%eax),%eax
 11d:	83 ec 04             	sub    $0x4,%esp
 120:	50                   	push   %eax
 121:	68 68 0a 00 00       	push   $0xa68
 126:	6a 02                	push   $0x2
 128:	e8 64 05 00 00       	call   691 <printf>
 12d:	83 c4 10             	add    $0x10,%esp
        exit();
 130:	e8 a5 03 00 00       	call   4da <exit>

    } else if(ret == -1) {
 135:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 139:	75 17                	jne    152 <main+0xbd>
        printf(2, "ERROR: fork failed\n");
 13b:	83 ec 08             	sub    $0x8,%esp
 13e:	68 8a 0a 00 00       	push   $0xa8a
 143:	6a 02                	push   $0x2
 145:	e8 47 05 00 00       	call   691 <printf>
 14a:	83 c4 10             	add    $0x10,%esp
        exit();
 14d:	e8 88 03 00 00       	call   4da <exit>

    } else {
        t1 = uptime();
 152:	e8 1b 04 00 00       	call   572 <uptime>
 157:	89 45 f0             	mov    %eax,-0x10(%ebp)
        wait();
 15a:	e8 83 03 00 00       	call   4e2 <wait>
        t2 = uptime();
 15f:	e8 0e 04 00 00       	call   572 <uptime>
 164:	89 45 ec             	mov    %eax,-0x14(%ebp)
        running_time = t2 - t1;
 167:	8b 45 ec             	mov    -0x14(%ebp),%eax
 16a:	2b 45 f0             	sub    -0x10(%ebp),%eax
 16d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }

    printf(1, "%s ran in ", argv[1]);
 170:	8b 43 04             	mov    0x4(%ebx),%eax
 173:	83 c0 04             	add    $0x4,%eax
 176:	8b 00                	mov    (%eax),%eax
 178:	83 ec 04             	sub    $0x4,%esp
 17b:	50                   	push   %eax
 17c:	68 9e 0a 00 00       	push   $0xa9e
 181:	6a 01                	push   $0x1
 183:	e8 09 05 00 00       	call   691 <printf>
 188:	83 c4 10             	add    $0x10,%esp
    print_ticks_as_seconds(running_time);
 18b:	83 ec 0c             	sub    $0xc,%esp
 18e:	ff 75 e8             	pushl  -0x18(%ebp)
 191:	e8 6a fe ff ff       	call   0 <print_ticks_as_seconds>
 196:	83 c4 10             	add    $0x10,%esp
    printf(1, " seconds.\n");            
 199:	83 ec 08             	sub    $0x8,%esp
 19c:	68 5c 0a 00 00       	push   $0xa5c
 1a1:	6a 01                	push   $0x1
 1a3:	e8 e9 04 00 00       	call   691 <printf>
 1a8:	83 c4 10             	add    $0x10,%esp
    exit();
 1ab:	e8 2a 03 00 00       	call   4da <exit>

000001b0 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	57                   	push   %edi
 1b4:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 1b5:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1b8:	8b 55 10             	mov    0x10(%ebp),%edx
 1bb:	8b 45 0c             	mov    0xc(%ebp),%eax
 1be:	89 cb                	mov    %ecx,%ebx
 1c0:	89 df                	mov    %ebx,%edi
 1c2:	89 d1                	mov    %edx,%ecx
 1c4:	fc                   	cld    
 1c5:	f3 aa                	rep stos %al,%es:(%edi)
 1c7:	89 ca                	mov    %ecx,%edx
 1c9:	89 fb                	mov    %edi,%ebx
 1cb:	89 5d 08             	mov    %ebx,0x8(%ebp)
 1ce:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 1d1:	90                   	nop
 1d2:	5b                   	pop    %ebx
 1d3:	5f                   	pop    %edi
 1d4:	5d                   	pop    %ebp
 1d5:	c3                   	ret    

000001d6 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1d6:	55                   	push   %ebp
 1d7:	89 e5                	mov    %esp,%ebp
 1d9:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 1dc:	8b 45 08             	mov    0x8(%ebp),%eax
 1df:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 1e2:	90                   	nop
 1e3:	8b 45 08             	mov    0x8(%ebp),%eax
 1e6:	8d 50 01             	lea    0x1(%eax),%edx
 1e9:	89 55 08             	mov    %edx,0x8(%ebp)
 1ec:	8b 55 0c             	mov    0xc(%ebp),%edx
 1ef:	8d 4a 01             	lea    0x1(%edx),%ecx
 1f2:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 1f5:	0f b6 12             	movzbl (%edx),%edx
 1f8:	88 10                	mov    %dl,(%eax)
 1fa:	0f b6 00             	movzbl (%eax),%eax
 1fd:	84 c0                	test   %al,%al
 1ff:	75 e2                	jne    1e3 <strcpy+0xd>
    ;
  return os;
 201:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 204:	c9                   	leave  
 205:	c3                   	ret    

00000206 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 206:	55                   	push   %ebp
 207:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 209:	eb 08                	jmp    213 <strcmp+0xd>
    p++, q++;
 20b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 20f:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 213:	8b 45 08             	mov    0x8(%ebp),%eax
 216:	0f b6 00             	movzbl (%eax),%eax
 219:	84 c0                	test   %al,%al
 21b:	74 10                	je     22d <strcmp+0x27>
 21d:	8b 45 08             	mov    0x8(%ebp),%eax
 220:	0f b6 10             	movzbl (%eax),%edx
 223:	8b 45 0c             	mov    0xc(%ebp),%eax
 226:	0f b6 00             	movzbl (%eax),%eax
 229:	38 c2                	cmp    %al,%dl
 22b:	74 de                	je     20b <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 22d:	8b 45 08             	mov    0x8(%ebp),%eax
 230:	0f b6 00             	movzbl (%eax),%eax
 233:	0f b6 d0             	movzbl %al,%edx
 236:	8b 45 0c             	mov    0xc(%ebp),%eax
 239:	0f b6 00             	movzbl (%eax),%eax
 23c:	0f b6 c0             	movzbl %al,%eax
 23f:	29 c2                	sub    %eax,%edx
 241:	89 d0                	mov    %edx,%eax
}
 243:	5d                   	pop    %ebp
 244:	c3                   	ret    

00000245 <strlen>:

uint
strlen(char *s)
{
 245:	55                   	push   %ebp
 246:	89 e5                	mov    %esp,%ebp
 248:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 24b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 252:	eb 04                	jmp    258 <strlen+0x13>
 254:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 258:	8b 55 fc             	mov    -0x4(%ebp),%edx
 25b:	8b 45 08             	mov    0x8(%ebp),%eax
 25e:	01 d0                	add    %edx,%eax
 260:	0f b6 00             	movzbl (%eax),%eax
 263:	84 c0                	test   %al,%al
 265:	75 ed                	jne    254 <strlen+0xf>
    ;
  return n;
 267:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 26a:	c9                   	leave  
 26b:	c3                   	ret    

0000026c <memset>:

void*
memset(void *dst, int c, uint n)
{
 26c:	55                   	push   %ebp
 26d:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 26f:	8b 45 10             	mov    0x10(%ebp),%eax
 272:	50                   	push   %eax
 273:	ff 75 0c             	pushl  0xc(%ebp)
 276:	ff 75 08             	pushl  0x8(%ebp)
 279:	e8 32 ff ff ff       	call   1b0 <stosb>
 27e:	83 c4 0c             	add    $0xc,%esp
  return dst;
 281:	8b 45 08             	mov    0x8(%ebp),%eax
}
 284:	c9                   	leave  
 285:	c3                   	ret    

00000286 <strchr>:

char*
strchr(const char *s, char c)
{
 286:	55                   	push   %ebp
 287:	89 e5                	mov    %esp,%ebp
 289:	83 ec 04             	sub    $0x4,%esp
 28c:	8b 45 0c             	mov    0xc(%ebp),%eax
 28f:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 292:	eb 14                	jmp    2a8 <strchr+0x22>
    if(*s == c)
 294:	8b 45 08             	mov    0x8(%ebp),%eax
 297:	0f b6 00             	movzbl (%eax),%eax
 29a:	3a 45 fc             	cmp    -0x4(%ebp),%al
 29d:	75 05                	jne    2a4 <strchr+0x1e>
      return (char*)s;
 29f:	8b 45 08             	mov    0x8(%ebp),%eax
 2a2:	eb 13                	jmp    2b7 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 2a4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 2a8:	8b 45 08             	mov    0x8(%ebp),%eax
 2ab:	0f b6 00             	movzbl (%eax),%eax
 2ae:	84 c0                	test   %al,%al
 2b0:	75 e2                	jne    294 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 2b2:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2b7:	c9                   	leave  
 2b8:	c3                   	ret    

000002b9 <gets>:

char*
gets(char *buf, int max)
{
 2b9:	55                   	push   %ebp
 2ba:	89 e5                	mov    %esp,%ebp
 2bc:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2bf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2c6:	eb 42                	jmp    30a <gets+0x51>
    cc = read(0, &c, 1);
 2c8:	83 ec 04             	sub    $0x4,%esp
 2cb:	6a 01                	push   $0x1
 2cd:	8d 45 ef             	lea    -0x11(%ebp),%eax
 2d0:	50                   	push   %eax
 2d1:	6a 00                	push   $0x0
 2d3:	e8 1a 02 00 00       	call   4f2 <read>
 2d8:	83 c4 10             	add    $0x10,%esp
 2db:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 2de:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2e2:	7e 33                	jle    317 <gets+0x5e>
      break;
    buf[i++] = c;
 2e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2e7:	8d 50 01             	lea    0x1(%eax),%edx
 2ea:	89 55 f4             	mov    %edx,-0xc(%ebp)
 2ed:	89 c2                	mov    %eax,%edx
 2ef:	8b 45 08             	mov    0x8(%ebp),%eax
 2f2:	01 c2                	add    %eax,%edx
 2f4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2f8:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 2fa:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2fe:	3c 0a                	cmp    $0xa,%al
 300:	74 16                	je     318 <gets+0x5f>
 302:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 306:	3c 0d                	cmp    $0xd,%al
 308:	74 0e                	je     318 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 30a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 30d:	83 c0 01             	add    $0x1,%eax
 310:	3b 45 0c             	cmp    0xc(%ebp),%eax
 313:	7c b3                	jl     2c8 <gets+0xf>
 315:	eb 01                	jmp    318 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 317:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 318:	8b 55 f4             	mov    -0xc(%ebp),%edx
 31b:	8b 45 08             	mov    0x8(%ebp),%eax
 31e:	01 d0                	add    %edx,%eax
 320:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 323:	8b 45 08             	mov    0x8(%ebp),%eax
}
 326:	c9                   	leave  
 327:	c3                   	ret    

00000328 <stat>:

int
stat(char *n, struct stat *st)
{
 328:	55                   	push   %ebp
 329:	89 e5                	mov    %esp,%ebp
 32b:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 32e:	83 ec 08             	sub    $0x8,%esp
 331:	6a 00                	push   $0x0
 333:	ff 75 08             	pushl  0x8(%ebp)
 336:	e8 df 01 00 00       	call   51a <open>
 33b:	83 c4 10             	add    $0x10,%esp
 33e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 341:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 345:	79 07                	jns    34e <stat+0x26>
    return -1;
 347:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 34c:	eb 25                	jmp    373 <stat+0x4b>
  r = fstat(fd, st);
 34e:	83 ec 08             	sub    $0x8,%esp
 351:	ff 75 0c             	pushl  0xc(%ebp)
 354:	ff 75 f4             	pushl  -0xc(%ebp)
 357:	e8 d6 01 00 00       	call   532 <fstat>
 35c:	83 c4 10             	add    $0x10,%esp
 35f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 362:	83 ec 0c             	sub    $0xc,%esp
 365:	ff 75 f4             	pushl  -0xc(%ebp)
 368:	e8 95 01 00 00       	call   502 <close>
 36d:	83 c4 10             	add    $0x10,%esp
  return r;
 370:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 373:	c9                   	leave  
 374:	c3                   	ret    

00000375 <atoi>:

int
atoi(const char *s)
{
 375:	55                   	push   %ebp
 376:	89 e5                	mov    %esp,%ebp
 378:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 37b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 382:	eb 04                	jmp    388 <atoi+0x13>
 384:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 388:	8b 45 08             	mov    0x8(%ebp),%eax
 38b:	0f b6 00             	movzbl (%eax),%eax
 38e:	3c 20                	cmp    $0x20,%al
 390:	74 f2                	je     384 <atoi+0xf>
  sign = (*s == '-') ? -1 : 1;
 392:	8b 45 08             	mov    0x8(%ebp),%eax
 395:	0f b6 00             	movzbl (%eax),%eax
 398:	3c 2d                	cmp    $0x2d,%al
 39a:	75 07                	jne    3a3 <atoi+0x2e>
 39c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 3a1:	eb 05                	jmp    3a8 <atoi+0x33>
 3a3:	b8 01 00 00 00       	mov    $0x1,%eax
 3a8:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 3ab:	8b 45 08             	mov    0x8(%ebp),%eax
 3ae:	0f b6 00             	movzbl (%eax),%eax
 3b1:	3c 2b                	cmp    $0x2b,%al
 3b3:	74 0a                	je     3bf <atoi+0x4a>
 3b5:	8b 45 08             	mov    0x8(%ebp),%eax
 3b8:	0f b6 00             	movzbl (%eax),%eax
 3bb:	3c 2d                	cmp    $0x2d,%al
 3bd:	75 2b                	jne    3ea <atoi+0x75>
    s++;
 3bf:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
 3c3:	eb 25                	jmp    3ea <atoi+0x75>
    n = n*10 + *s++ - '0';
 3c5:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3c8:	89 d0                	mov    %edx,%eax
 3ca:	c1 e0 02             	shl    $0x2,%eax
 3cd:	01 d0                	add    %edx,%eax
 3cf:	01 c0                	add    %eax,%eax
 3d1:	89 c1                	mov    %eax,%ecx
 3d3:	8b 45 08             	mov    0x8(%ebp),%eax
 3d6:	8d 50 01             	lea    0x1(%eax),%edx
 3d9:	89 55 08             	mov    %edx,0x8(%ebp)
 3dc:	0f b6 00             	movzbl (%eax),%eax
 3df:	0f be c0             	movsbl %al,%eax
 3e2:	01 c8                	add    %ecx,%eax
 3e4:	83 e8 30             	sub    $0x30,%eax
 3e7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  n = 0;
  while (*s == ' ') s++;
  sign = (*s == '-') ? -1 : 1;
  if (*s == '+'  || *s == '-')
    s++;
  while('0' <= *s && *s <= '9')
 3ea:	8b 45 08             	mov    0x8(%ebp),%eax
 3ed:	0f b6 00             	movzbl (%eax),%eax
 3f0:	3c 2f                	cmp    $0x2f,%al
 3f2:	7e 0a                	jle    3fe <atoi+0x89>
 3f4:	8b 45 08             	mov    0x8(%ebp),%eax
 3f7:	0f b6 00             	movzbl (%eax),%eax
 3fa:	3c 39                	cmp    $0x39,%al
 3fc:	7e c7                	jle    3c5 <atoi+0x50>
    n = n*10 + *s++ - '0';
  return sign*n;
 3fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
 401:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 405:	c9                   	leave  
 406:	c3                   	ret    

00000407 <atoo>:

int
atoo(const char *s)
{
 407:	55                   	push   %ebp
 408:	89 e5                	mov    %esp,%ebp
 40a:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 40d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 414:	eb 04                	jmp    41a <atoo+0x13>
 416:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 41a:	8b 45 08             	mov    0x8(%ebp),%eax
 41d:	0f b6 00             	movzbl (%eax),%eax
 420:	3c 20                	cmp    $0x20,%al
 422:	74 f2                	je     416 <atoo+0xf>
  sign = (*s == '-') ? -1 : 1;
 424:	8b 45 08             	mov    0x8(%ebp),%eax
 427:	0f b6 00             	movzbl (%eax),%eax
 42a:	3c 2d                	cmp    $0x2d,%al
 42c:	75 07                	jne    435 <atoo+0x2e>
 42e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 433:	eb 05                	jmp    43a <atoo+0x33>
 435:	b8 01 00 00 00       	mov    $0x1,%eax
 43a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 43d:	8b 45 08             	mov    0x8(%ebp),%eax
 440:	0f b6 00             	movzbl (%eax),%eax
 443:	3c 2b                	cmp    $0x2b,%al
 445:	74 0a                	je     451 <atoo+0x4a>
 447:	8b 45 08             	mov    0x8(%ebp),%eax
 44a:	0f b6 00             	movzbl (%eax),%eax
 44d:	3c 2d                	cmp    $0x2d,%al
 44f:	75 27                	jne    478 <atoo+0x71>
    s++;
 451:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
 455:	eb 21                	jmp    478 <atoo+0x71>
    n = n*8 + *s++ - '0';
 457:	8b 45 fc             	mov    -0x4(%ebp),%eax
 45a:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
 461:	8b 45 08             	mov    0x8(%ebp),%eax
 464:	8d 50 01             	lea    0x1(%eax),%edx
 467:	89 55 08             	mov    %edx,0x8(%ebp)
 46a:	0f b6 00             	movzbl (%eax),%eax
 46d:	0f be c0             	movsbl %al,%eax
 470:	01 c8                	add    %ecx,%eax
 472:	83 e8 30             	sub    $0x30,%eax
 475:	89 45 fc             	mov    %eax,-0x4(%ebp)
  n = 0;
  while (*s == ' ') s++;
  sign = (*s == '-') ? -1 : 1;
  if (*s == '+'  || *s == '-')
    s++;
  while('0' <= *s && *s <= '7')
 478:	8b 45 08             	mov    0x8(%ebp),%eax
 47b:	0f b6 00             	movzbl (%eax),%eax
 47e:	3c 2f                	cmp    $0x2f,%al
 480:	7e 0a                	jle    48c <atoo+0x85>
 482:	8b 45 08             	mov    0x8(%ebp),%eax
 485:	0f b6 00             	movzbl (%eax),%eax
 488:	3c 37                	cmp    $0x37,%al
 48a:	7e cb                	jle    457 <atoo+0x50>
    n = n*8 + *s++ - '0';
  return sign*n;
 48c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 48f:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 493:	c9                   	leave  
 494:	c3                   	ret    

00000495 <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
 495:	55                   	push   %ebp
 496:	89 e5                	mov    %esp,%ebp
 498:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 49b:	8b 45 08             	mov    0x8(%ebp),%eax
 49e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 4a1:	8b 45 0c             	mov    0xc(%ebp),%eax
 4a4:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 4a7:	eb 17                	jmp    4c0 <memmove+0x2b>
    *dst++ = *src++;
 4a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 4ac:	8d 50 01             	lea    0x1(%eax),%edx
 4af:	89 55 fc             	mov    %edx,-0x4(%ebp)
 4b2:	8b 55 f8             	mov    -0x8(%ebp),%edx
 4b5:	8d 4a 01             	lea    0x1(%edx),%ecx
 4b8:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 4bb:	0f b6 12             	movzbl (%edx),%edx
 4be:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4c0:	8b 45 10             	mov    0x10(%ebp),%eax
 4c3:	8d 50 ff             	lea    -0x1(%eax),%edx
 4c6:	89 55 10             	mov    %edx,0x10(%ebp)
 4c9:	85 c0                	test   %eax,%eax
 4cb:	7f dc                	jg     4a9 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 4cd:	8b 45 08             	mov    0x8(%ebp),%eax
}
 4d0:	c9                   	leave  
 4d1:	c3                   	ret    

000004d2 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4d2:	b8 01 00 00 00       	mov    $0x1,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    

000004da <exit>:
SYSCALL(exit)
 4da:	b8 02 00 00 00       	mov    $0x2,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret    

000004e2 <wait>:
SYSCALL(wait)
 4e2:	b8 03 00 00 00       	mov    $0x3,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret    

000004ea <pipe>:
SYSCALL(pipe)
 4ea:	b8 04 00 00 00       	mov    $0x4,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    

000004f2 <read>:
SYSCALL(read)
 4f2:	b8 05 00 00 00       	mov    $0x5,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret    

000004fa <write>:
SYSCALL(write)
 4fa:	b8 10 00 00 00       	mov    $0x10,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret    

00000502 <close>:
SYSCALL(close)
 502:	b8 15 00 00 00       	mov    $0x15,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret    

0000050a <kill>:
SYSCALL(kill)
 50a:	b8 06 00 00 00       	mov    $0x6,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret    

00000512 <exec>:
SYSCALL(exec)
 512:	b8 07 00 00 00       	mov    $0x7,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret    

0000051a <open>:
SYSCALL(open)
 51a:	b8 0f 00 00 00       	mov    $0xf,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret    

00000522 <mknod>:
SYSCALL(mknod)
 522:	b8 11 00 00 00       	mov    $0x11,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret    

0000052a <unlink>:
SYSCALL(unlink)
 52a:	b8 12 00 00 00       	mov    $0x12,%eax
 52f:	cd 40                	int    $0x40
 531:	c3                   	ret    

00000532 <fstat>:
SYSCALL(fstat)
 532:	b8 08 00 00 00       	mov    $0x8,%eax
 537:	cd 40                	int    $0x40
 539:	c3                   	ret    

0000053a <link>:
SYSCALL(link)
 53a:	b8 13 00 00 00       	mov    $0x13,%eax
 53f:	cd 40                	int    $0x40
 541:	c3                   	ret    

00000542 <mkdir>:
SYSCALL(mkdir)
 542:	b8 14 00 00 00       	mov    $0x14,%eax
 547:	cd 40                	int    $0x40
 549:	c3                   	ret    

0000054a <chdir>:
SYSCALL(chdir)
 54a:	b8 09 00 00 00       	mov    $0x9,%eax
 54f:	cd 40                	int    $0x40
 551:	c3                   	ret    

00000552 <dup>:
SYSCALL(dup)
 552:	b8 0a 00 00 00       	mov    $0xa,%eax
 557:	cd 40                	int    $0x40
 559:	c3                   	ret    

0000055a <getpid>:
SYSCALL(getpid)
 55a:	b8 0b 00 00 00       	mov    $0xb,%eax
 55f:	cd 40                	int    $0x40
 561:	c3                   	ret    

00000562 <sbrk>:
SYSCALL(sbrk)
 562:	b8 0c 00 00 00       	mov    $0xc,%eax
 567:	cd 40                	int    $0x40
 569:	c3                   	ret    

0000056a <sleep>:
SYSCALL(sleep)
 56a:	b8 0d 00 00 00       	mov    $0xd,%eax
 56f:	cd 40                	int    $0x40
 571:	c3                   	ret    

00000572 <uptime>:
SYSCALL(uptime)
 572:	b8 0e 00 00 00       	mov    $0xe,%eax
 577:	cd 40                	int    $0x40
 579:	c3                   	ret    

0000057a <halt>:
SYSCALL(halt)
 57a:	b8 16 00 00 00       	mov    $0x16,%eax
 57f:	cd 40                	int    $0x40
 581:	c3                   	ret    

00000582 <date>:
SYSCALL(date)
 582:	b8 17 00 00 00       	mov    $0x17,%eax
 587:	cd 40                	int    $0x40
 589:	c3                   	ret    

0000058a <getuid>:
SYSCALL(getuid)
 58a:	b8 18 00 00 00       	mov    $0x18,%eax
 58f:	cd 40                	int    $0x40
 591:	c3                   	ret    

00000592 <getgid>:
SYSCALL(getgid)
 592:	b8 19 00 00 00       	mov    $0x19,%eax
 597:	cd 40                	int    $0x40
 599:	c3                   	ret    

0000059a <getppid>:
SYSCALL(getppid)
 59a:	b8 1a 00 00 00       	mov    $0x1a,%eax
 59f:	cd 40                	int    $0x40
 5a1:	c3                   	ret    

000005a2 <setuid>:
SYSCALL(setuid)
 5a2:	b8 1b 00 00 00       	mov    $0x1b,%eax
 5a7:	cd 40                	int    $0x40
 5a9:	c3                   	ret    

000005aa <setgid>:
SYSCALL(setgid)
 5aa:	b8 1c 00 00 00       	mov    $0x1c,%eax
 5af:	cd 40                	int    $0x40
 5b1:	c3                   	ret    

000005b2 <getprocs>:
SYSCALL(getprocs)
 5b2:	b8 1d 00 00 00       	mov    $0x1d,%eax
 5b7:	cd 40                	int    $0x40
 5b9:	c3                   	ret    

000005ba <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 5ba:	55                   	push   %ebp
 5bb:	89 e5                	mov    %esp,%ebp
 5bd:	83 ec 18             	sub    $0x18,%esp
 5c0:	8b 45 0c             	mov    0xc(%ebp),%eax
 5c3:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 5c6:	83 ec 04             	sub    $0x4,%esp
 5c9:	6a 01                	push   $0x1
 5cb:	8d 45 f4             	lea    -0xc(%ebp),%eax
 5ce:	50                   	push   %eax
 5cf:	ff 75 08             	pushl  0x8(%ebp)
 5d2:	e8 23 ff ff ff       	call   4fa <write>
 5d7:	83 c4 10             	add    $0x10,%esp
}
 5da:	90                   	nop
 5db:	c9                   	leave  
 5dc:	c3                   	ret    

000005dd <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5dd:	55                   	push   %ebp
 5de:	89 e5                	mov    %esp,%ebp
 5e0:	53                   	push   %ebx
 5e1:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 5e4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 5eb:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 5ef:	74 17                	je     608 <printint+0x2b>
 5f1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 5f5:	79 11                	jns    608 <printint+0x2b>
    neg = 1;
 5f7:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 5fe:	8b 45 0c             	mov    0xc(%ebp),%eax
 601:	f7 d8                	neg    %eax
 603:	89 45 ec             	mov    %eax,-0x14(%ebp)
 606:	eb 06                	jmp    60e <printint+0x31>
  } else {
    x = xx;
 608:	8b 45 0c             	mov    0xc(%ebp),%eax
 60b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 60e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 615:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 618:	8d 41 01             	lea    0x1(%ecx),%eax
 61b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 61e:	8b 5d 10             	mov    0x10(%ebp),%ebx
 621:	8b 45 ec             	mov    -0x14(%ebp),%eax
 624:	ba 00 00 00 00       	mov    $0x0,%edx
 629:	f7 f3                	div    %ebx
 62b:	89 d0                	mov    %edx,%eax
 62d:	0f b6 80 3c 0d 00 00 	movzbl 0xd3c(%eax),%eax
 634:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 638:	8b 5d 10             	mov    0x10(%ebp),%ebx
 63b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 63e:	ba 00 00 00 00       	mov    $0x0,%edx
 643:	f7 f3                	div    %ebx
 645:	89 45 ec             	mov    %eax,-0x14(%ebp)
 648:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 64c:	75 c7                	jne    615 <printint+0x38>
  if(neg)
 64e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 652:	74 2d                	je     681 <printint+0xa4>
    buf[i++] = '-';
 654:	8b 45 f4             	mov    -0xc(%ebp),%eax
 657:	8d 50 01             	lea    0x1(%eax),%edx
 65a:	89 55 f4             	mov    %edx,-0xc(%ebp)
 65d:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 662:	eb 1d                	jmp    681 <printint+0xa4>
    putc(fd, buf[i]);
 664:	8d 55 dc             	lea    -0x24(%ebp),%edx
 667:	8b 45 f4             	mov    -0xc(%ebp),%eax
 66a:	01 d0                	add    %edx,%eax
 66c:	0f b6 00             	movzbl (%eax),%eax
 66f:	0f be c0             	movsbl %al,%eax
 672:	83 ec 08             	sub    $0x8,%esp
 675:	50                   	push   %eax
 676:	ff 75 08             	pushl  0x8(%ebp)
 679:	e8 3c ff ff ff       	call   5ba <putc>
 67e:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 681:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 685:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 689:	79 d9                	jns    664 <printint+0x87>
    putc(fd, buf[i]);
}
 68b:	90                   	nop
 68c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 68f:	c9                   	leave  
 690:	c3                   	ret    

00000691 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 691:	55                   	push   %ebp
 692:	89 e5                	mov    %esp,%ebp
 694:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 697:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 69e:	8d 45 0c             	lea    0xc(%ebp),%eax
 6a1:	83 c0 04             	add    $0x4,%eax
 6a4:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 6a7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 6ae:	e9 59 01 00 00       	jmp    80c <printf+0x17b>
    c = fmt[i] & 0xff;
 6b3:	8b 55 0c             	mov    0xc(%ebp),%edx
 6b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6b9:	01 d0                	add    %edx,%eax
 6bb:	0f b6 00             	movzbl (%eax),%eax
 6be:	0f be c0             	movsbl %al,%eax
 6c1:	25 ff 00 00 00       	and    $0xff,%eax
 6c6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 6c9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 6cd:	75 2c                	jne    6fb <printf+0x6a>
      if(c == '%'){
 6cf:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6d3:	75 0c                	jne    6e1 <printf+0x50>
        state = '%';
 6d5:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 6dc:	e9 27 01 00 00       	jmp    808 <printf+0x177>
      } else {
        putc(fd, c);
 6e1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6e4:	0f be c0             	movsbl %al,%eax
 6e7:	83 ec 08             	sub    $0x8,%esp
 6ea:	50                   	push   %eax
 6eb:	ff 75 08             	pushl  0x8(%ebp)
 6ee:	e8 c7 fe ff ff       	call   5ba <putc>
 6f3:	83 c4 10             	add    $0x10,%esp
 6f6:	e9 0d 01 00 00       	jmp    808 <printf+0x177>
      }
    } else if(state == '%'){
 6fb:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 6ff:	0f 85 03 01 00 00    	jne    808 <printf+0x177>
      if(c == 'd'){
 705:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 709:	75 1e                	jne    729 <printf+0x98>
        printint(fd, *ap, 10, 1);
 70b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 70e:	8b 00                	mov    (%eax),%eax
 710:	6a 01                	push   $0x1
 712:	6a 0a                	push   $0xa
 714:	50                   	push   %eax
 715:	ff 75 08             	pushl  0x8(%ebp)
 718:	e8 c0 fe ff ff       	call   5dd <printint>
 71d:	83 c4 10             	add    $0x10,%esp
        ap++;
 720:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 724:	e9 d8 00 00 00       	jmp    801 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 729:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 72d:	74 06                	je     735 <printf+0xa4>
 72f:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 733:	75 1e                	jne    753 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 735:	8b 45 e8             	mov    -0x18(%ebp),%eax
 738:	8b 00                	mov    (%eax),%eax
 73a:	6a 00                	push   $0x0
 73c:	6a 10                	push   $0x10
 73e:	50                   	push   %eax
 73f:	ff 75 08             	pushl  0x8(%ebp)
 742:	e8 96 fe ff ff       	call   5dd <printint>
 747:	83 c4 10             	add    $0x10,%esp
        ap++;
 74a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 74e:	e9 ae 00 00 00       	jmp    801 <printf+0x170>
      } else if(c == 's'){
 753:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 757:	75 43                	jne    79c <printf+0x10b>
        s = (char*)*ap;
 759:	8b 45 e8             	mov    -0x18(%ebp),%eax
 75c:	8b 00                	mov    (%eax),%eax
 75e:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 761:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 765:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 769:	75 25                	jne    790 <printf+0xff>
          s = "(null)";
 76b:	c7 45 f4 a9 0a 00 00 	movl   $0xaa9,-0xc(%ebp)
        while(*s != 0){
 772:	eb 1c                	jmp    790 <printf+0xff>
          putc(fd, *s);
 774:	8b 45 f4             	mov    -0xc(%ebp),%eax
 777:	0f b6 00             	movzbl (%eax),%eax
 77a:	0f be c0             	movsbl %al,%eax
 77d:	83 ec 08             	sub    $0x8,%esp
 780:	50                   	push   %eax
 781:	ff 75 08             	pushl  0x8(%ebp)
 784:	e8 31 fe ff ff       	call   5ba <putc>
 789:	83 c4 10             	add    $0x10,%esp
          s++;
 78c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 790:	8b 45 f4             	mov    -0xc(%ebp),%eax
 793:	0f b6 00             	movzbl (%eax),%eax
 796:	84 c0                	test   %al,%al
 798:	75 da                	jne    774 <printf+0xe3>
 79a:	eb 65                	jmp    801 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 79c:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 7a0:	75 1d                	jne    7bf <printf+0x12e>
        putc(fd, *ap);
 7a2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7a5:	8b 00                	mov    (%eax),%eax
 7a7:	0f be c0             	movsbl %al,%eax
 7aa:	83 ec 08             	sub    $0x8,%esp
 7ad:	50                   	push   %eax
 7ae:	ff 75 08             	pushl  0x8(%ebp)
 7b1:	e8 04 fe ff ff       	call   5ba <putc>
 7b6:	83 c4 10             	add    $0x10,%esp
        ap++;
 7b9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7bd:	eb 42                	jmp    801 <printf+0x170>
      } else if(c == '%'){
 7bf:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7c3:	75 17                	jne    7dc <printf+0x14b>
        putc(fd, c);
 7c5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7c8:	0f be c0             	movsbl %al,%eax
 7cb:	83 ec 08             	sub    $0x8,%esp
 7ce:	50                   	push   %eax
 7cf:	ff 75 08             	pushl  0x8(%ebp)
 7d2:	e8 e3 fd ff ff       	call   5ba <putc>
 7d7:	83 c4 10             	add    $0x10,%esp
 7da:	eb 25                	jmp    801 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7dc:	83 ec 08             	sub    $0x8,%esp
 7df:	6a 25                	push   $0x25
 7e1:	ff 75 08             	pushl  0x8(%ebp)
 7e4:	e8 d1 fd ff ff       	call   5ba <putc>
 7e9:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 7ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7ef:	0f be c0             	movsbl %al,%eax
 7f2:	83 ec 08             	sub    $0x8,%esp
 7f5:	50                   	push   %eax
 7f6:	ff 75 08             	pushl  0x8(%ebp)
 7f9:	e8 bc fd ff ff       	call   5ba <putc>
 7fe:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 801:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 808:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 80c:	8b 55 0c             	mov    0xc(%ebp),%edx
 80f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 812:	01 d0                	add    %edx,%eax
 814:	0f b6 00             	movzbl (%eax),%eax
 817:	84 c0                	test   %al,%al
 819:	0f 85 94 fe ff ff    	jne    6b3 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 81f:	90                   	nop
 820:	c9                   	leave  
 821:	c3                   	ret    

00000822 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 822:	55                   	push   %ebp
 823:	89 e5                	mov    %esp,%ebp
 825:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 828:	8b 45 08             	mov    0x8(%ebp),%eax
 82b:	83 e8 08             	sub    $0x8,%eax
 82e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 831:	a1 58 0d 00 00       	mov    0xd58,%eax
 836:	89 45 fc             	mov    %eax,-0x4(%ebp)
 839:	eb 24                	jmp    85f <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 83b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 83e:	8b 00                	mov    (%eax),%eax
 840:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 843:	77 12                	ja     857 <free+0x35>
 845:	8b 45 f8             	mov    -0x8(%ebp),%eax
 848:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 84b:	77 24                	ja     871 <free+0x4f>
 84d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 850:	8b 00                	mov    (%eax),%eax
 852:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 855:	77 1a                	ja     871 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 857:	8b 45 fc             	mov    -0x4(%ebp),%eax
 85a:	8b 00                	mov    (%eax),%eax
 85c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 85f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 862:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 865:	76 d4                	jbe    83b <free+0x19>
 867:	8b 45 fc             	mov    -0x4(%ebp),%eax
 86a:	8b 00                	mov    (%eax),%eax
 86c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 86f:	76 ca                	jbe    83b <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 871:	8b 45 f8             	mov    -0x8(%ebp),%eax
 874:	8b 40 04             	mov    0x4(%eax),%eax
 877:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 87e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 881:	01 c2                	add    %eax,%edx
 883:	8b 45 fc             	mov    -0x4(%ebp),%eax
 886:	8b 00                	mov    (%eax),%eax
 888:	39 c2                	cmp    %eax,%edx
 88a:	75 24                	jne    8b0 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 88c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 88f:	8b 50 04             	mov    0x4(%eax),%edx
 892:	8b 45 fc             	mov    -0x4(%ebp),%eax
 895:	8b 00                	mov    (%eax),%eax
 897:	8b 40 04             	mov    0x4(%eax),%eax
 89a:	01 c2                	add    %eax,%edx
 89c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 89f:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 8a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8a5:	8b 00                	mov    (%eax),%eax
 8a7:	8b 10                	mov    (%eax),%edx
 8a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8ac:	89 10                	mov    %edx,(%eax)
 8ae:	eb 0a                	jmp    8ba <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 8b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8b3:	8b 10                	mov    (%eax),%edx
 8b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8b8:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 8ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8bd:	8b 40 04             	mov    0x4(%eax),%eax
 8c0:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8ca:	01 d0                	add    %edx,%eax
 8cc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8cf:	75 20                	jne    8f1 <free+0xcf>
    p->s.size += bp->s.size;
 8d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8d4:	8b 50 04             	mov    0x4(%eax),%edx
 8d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8da:	8b 40 04             	mov    0x4(%eax),%eax
 8dd:	01 c2                	add    %eax,%edx
 8df:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8e2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 8e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8e8:	8b 10                	mov    (%eax),%edx
 8ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8ed:	89 10                	mov    %edx,(%eax)
 8ef:	eb 08                	jmp    8f9 <free+0xd7>
  } else
    p->s.ptr = bp;
 8f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8f4:	8b 55 f8             	mov    -0x8(%ebp),%edx
 8f7:	89 10                	mov    %edx,(%eax)
  freep = p;
 8f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8fc:	a3 58 0d 00 00       	mov    %eax,0xd58
}
 901:	90                   	nop
 902:	c9                   	leave  
 903:	c3                   	ret    

00000904 <morecore>:

static Header*
morecore(uint nu)
{
 904:	55                   	push   %ebp
 905:	89 e5                	mov    %esp,%ebp
 907:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 90a:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 911:	77 07                	ja     91a <morecore+0x16>
    nu = 4096;
 913:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 91a:	8b 45 08             	mov    0x8(%ebp),%eax
 91d:	c1 e0 03             	shl    $0x3,%eax
 920:	83 ec 0c             	sub    $0xc,%esp
 923:	50                   	push   %eax
 924:	e8 39 fc ff ff       	call   562 <sbrk>
 929:	83 c4 10             	add    $0x10,%esp
 92c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 92f:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 933:	75 07                	jne    93c <morecore+0x38>
    return 0;
 935:	b8 00 00 00 00       	mov    $0x0,%eax
 93a:	eb 26                	jmp    962 <morecore+0x5e>
  hp = (Header*)p;
 93c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 93f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 942:	8b 45 f0             	mov    -0x10(%ebp),%eax
 945:	8b 55 08             	mov    0x8(%ebp),%edx
 948:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 94b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 94e:	83 c0 08             	add    $0x8,%eax
 951:	83 ec 0c             	sub    $0xc,%esp
 954:	50                   	push   %eax
 955:	e8 c8 fe ff ff       	call   822 <free>
 95a:	83 c4 10             	add    $0x10,%esp
  return freep;
 95d:	a1 58 0d 00 00       	mov    0xd58,%eax
}
 962:	c9                   	leave  
 963:	c3                   	ret    

00000964 <malloc>:

void*
malloc(uint nbytes)
{
 964:	55                   	push   %ebp
 965:	89 e5                	mov    %esp,%ebp
 967:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 96a:	8b 45 08             	mov    0x8(%ebp),%eax
 96d:	83 c0 07             	add    $0x7,%eax
 970:	c1 e8 03             	shr    $0x3,%eax
 973:	83 c0 01             	add    $0x1,%eax
 976:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 979:	a1 58 0d 00 00       	mov    0xd58,%eax
 97e:	89 45 f0             	mov    %eax,-0x10(%ebp)
 981:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 985:	75 23                	jne    9aa <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 987:	c7 45 f0 50 0d 00 00 	movl   $0xd50,-0x10(%ebp)
 98e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 991:	a3 58 0d 00 00       	mov    %eax,0xd58
 996:	a1 58 0d 00 00       	mov    0xd58,%eax
 99b:	a3 50 0d 00 00       	mov    %eax,0xd50
    base.s.size = 0;
 9a0:	c7 05 54 0d 00 00 00 	movl   $0x0,0xd54
 9a7:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9ad:	8b 00                	mov    (%eax),%eax
 9af:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 9b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9b5:	8b 40 04             	mov    0x4(%eax),%eax
 9b8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9bb:	72 4d                	jb     a0a <malloc+0xa6>
      if(p->s.size == nunits)
 9bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9c0:	8b 40 04             	mov    0x4(%eax),%eax
 9c3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9c6:	75 0c                	jne    9d4 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 9c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9cb:	8b 10                	mov    (%eax),%edx
 9cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9d0:	89 10                	mov    %edx,(%eax)
 9d2:	eb 26                	jmp    9fa <malloc+0x96>
      else {
        p->s.size -= nunits;
 9d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9d7:	8b 40 04             	mov    0x4(%eax),%eax
 9da:	2b 45 ec             	sub    -0x14(%ebp),%eax
 9dd:	89 c2                	mov    %eax,%edx
 9df:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9e2:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 9e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9e8:	8b 40 04             	mov    0x4(%eax),%eax
 9eb:	c1 e0 03             	shl    $0x3,%eax
 9ee:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 9f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9f4:	8b 55 ec             	mov    -0x14(%ebp),%edx
 9f7:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 9fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9fd:	a3 58 0d 00 00       	mov    %eax,0xd58
      return (void*)(p + 1);
 a02:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a05:	83 c0 08             	add    $0x8,%eax
 a08:	eb 3b                	jmp    a45 <malloc+0xe1>
    }
    if(p == freep)
 a0a:	a1 58 0d 00 00       	mov    0xd58,%eax
 a0f:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 a12:	75 1e                	jne    a32 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 a14:	83 ec 0c             	sub    $0xc,%esp
 a17:	ff 75 ec             	pushl  -0x14(%ebp)
 a1a:	e8 e5 fe ff ff       	call   904 <morecore>
 a1f:	83 c4 10             	add    $0x10,%esp
 a22:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a25:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a29:	75 07                	jne    a32 <malloc+0xce>
        return 0;
 a2b:	b8 00 00 00 00       	mov    $0x0,%eax
 a30:	eb 13                	jmp    a45 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a32:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a35:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a38:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a3b:	8b 00                	mov    (%eax),%eax
 a3d:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 a40:	e9 6d ff ff ff       	jmp    9b2 <malloc+0x4e>
}
 a45:	c9                   	leave  
 a46:	c3                   	ret    
