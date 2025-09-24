
_proj0:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
   f:	83 ec 10             	sub    $0x10,%esp
  12:	89 cb                	mov    %ecx,%ebx
    printf(1, "CSE3320 proj0 printing in user space:");
  14:	83 ec 08             	sub    $0x8,%esp
  17:	68 f8 07 00 00       	push   $0x7f8
  1c:	6a 01                	push   $0x1
  1e:	e8 1d 04 00 00       	call   440 <printf>
  23:	83 c4 10             	add    $0x10,%esp
    for (int i = 1; i < argc; i++) {
  26:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  2d:	eb 28                	jmp    57 <main+0x57>
        printf(1, " %s", argv[i]);
  2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  32:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  39:	8b 43 04             	mov    0x4(%ebx),%eax
  3c:	01 d0                	add    %edx,%eax
  3e:	8b 00                	mov    (%eax),%eax
  40:	83 ec 04             	sub    $0x4,%esp
  43:	50                   	push   %eax
  44:	68 1e 08 00 00       	push   $0x81e
  49:	6a 01                	push   $0x1
  4b:	e8 f0 03 00 00       	call   440 <printf>
  50:	83 c4 10             	add    $0x10,%esp
    for (int i = 1; i < argc; i++) {
  53:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  57:	8b 45 f4             	mov    -0xc(%ebp),%eax
  5a:	3b 03                	cmp    (%ebx),%eax
  5c:	7c d1                	jl     2f <main+0x2f>
    }
    printf(1, "\n");
  5e:	83 ec 08             	sub    $0x8,%esp
  61:	68 22 08 00 00       	push   $0x822
  66:	6a 01                	push   $0x1
  68:	e8 d3 03 00 00       	call   440 <printf>
  6d:	83 c4 10             	add    $0x10,%esp
    exit();
  70:	e8 57 02 00 00       	call   2cc <exit>

00000075 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  75:	55                   	push   %ebp
  76:	89 e5                	mov    %esp,%ebp
  78:	57                   	push   %edi
  79:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  7a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  7d:	8b 55 10             	mov    0x10(%ebp),%edx
  80:	8b 45 0c             	mov    0xc(%ebp),%eax
  83:	89 cb                	mov    %ecx,%ebx
  85:	89 df                	mov    %ebx,%edi
  87:	89 d1                	mov    %edx,%ecx
  89:	fc                   	cld
  8a:	f3 aa                	rep stos %al,%es:(%edi)
  8c:	89 ca                	mov    %ecx,%edx
  8e:	89 fb                	mov    %edi,%ebx
  90:	89 5d 08             	mov    %ebx,0x8(%ebp)
  93:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  96:	90                   	nop
  97:	5b                   	pop    %ebx
  98:	5f                   	pop    %edi
  99:	5d                   	pop    %ebp
  9a:	c3                   	ret

0000009b <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  9b:	55                   	push   %ebp
  9c:	89 e5                	mov    %esp,%ebp
  9e:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  a1:	8b 45 08             	mov    0x8(%ebp),%eax
  a4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  a7:	90                   	nop
  a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  ab:	8d 42 01             	lea    0x1(%edx),%eax
  ae:	89 45 0c             	mov    %eax,0xc(%ebp)
  b1:	8b 45 08             	mov    0x8(%ebp),%eax
  b4:	8d 48 01             	lea    0x1(%eax),%ecx
  b7:	89 4d 08             	mov    %ecx,0x8(%ebp)
  ba:	0f b6 12             	movzbl (%edx),%edx
  bd:	88 10                	mov    %dl,(%eax)
  bf:	0f b6 00             	movzbl (%eax),%eax
  c2:	84 c0                	test   %al,%al
  c4:	75 e2                	jne    a8 <strcpy+0xd>
    ;
  return os;
  c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  c9:	c9                   	leave
  ca:	c3                   	ret

000000cb <strcmp>:

int
strcmp(const char *p, const char *q)
{
  cb:	55                   	push   %ebp
  cc:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  ce:	eb 08                	jmp    d8 <strcmp+0xd>
    p++, q++;
  d0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  d4:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
  d8:	8b 45 08             	mov    0x8(%ebp),%eax
  db:	0f b6 00             	movzbl (%eax),%eax
  de:	84 c0                	test   %al,%al
  e0:	74 10                	je     f2 <strcmp+0x27>
  e2:	8b 45 08             	mov    0x8(%ebp),%eax
  e5:	0f b6 10             	movzbl (%eax),%edx
  e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  eb:	0f b6 00             	movzbl (%eax),%eax
  ee:	38 c2                	cmp    %al,%dl
  f0:	74 de                	je     d0 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
  f2:	8b 45 08             	mov    0x8(%ebp),%eax
  f5:	0f b6 00             	movzbl (%eax),%eax
  f8:	0f b6 d0             	movzbl %al,%edx
  fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  fe:	0f b6 00             	movzbl (%eax),%eax
 101:	0f b6 c0             	movzbl %al,%eax
 104:	29 c2                	sub    %eax,%edx
 106:	89 d0                	mov    %edx,%eax
}
 108:	5d                   	pop    %ebp
 109:	c3                   	ret

0000010a <strlen>:

uint
strlen(char *s)
{
 10a:	55                   	push   %ebp
 10b:	89 e5                	mov    %esp,%ebp
 10d:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 110:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 117:	eb 04                	jmp    11d <strlen+0x13>
 119:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 11d:	8b 55 fc             	mov    -0x4(%ebp),%edx
 120:	8b 45 08             	mov    0x8(%ebp),%eax
 123:	01 d0                	add    %edx,%eax
 125:	0f b6 00             	movzbl (%eax),%eax
 128:	84 c0                	test   %al,%al
 12a:	75 ed                	jne    119 <strlen+0xf>
    ;
  return n;
 12c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 12f:	c9                   	leave
 130:	c3                   	ret

00000131 <memset>:

void*
memset(void *dst, int c, uint n)
{
 131:	55                   	push   %ebp
 132:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 134:	8b 45 10             	mov    0x10(%ebp),%eax
 137:	50                   	push   %eax
 138:	ff 75 0c             	push   0xc(%ebp)
 13b:	ff 75 08             	push   0x8(%ebp)
 13e:	e8 32 ff ff ff       	call   75 <stosb>
 143:	83 c4 0c             	add    $0xc,%esp
  return dst;
 146:	8b 45 08             	mov    0x8(%ebp),%eax
}
 149:	c9                   	leave
 14a:	c3                   	ret

0000014b <strchr>:

char*
strchr(const char *s, char c)
{
 14b:	55                   	push   %ebp
 14c:	89 e5                	mov    %esp,%ebp
 14e:	83 ec 04             	sub    $0x4,%esp
 151:	8b 45 0c             	mov    0xc(%ebp),%eax
 154:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 157:	eb 14                	jmp    16d <strchr+0x22>
    if(*s == c)
 159:	8b 45 08             	mov    0x8(%ebp),%eax
 15c:	0f b6 00             	movzbl (%eax),%eax
 15f:	38 45 fc             	cmp    %al,-0x4(%ebp)
 162:	75 05                	jne    169 <strchr+0x1e>
      return (char*)s;
 164:	8b 45 08             	mov    0x8(%ebp),%eax
 167:	eb 13                	jmp    17c <strchr+0x31>
  for(; *s; s++)
 169:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 16d:	8b 45 08             	mov    0x8(%ebp),%eax
 170:	0f b6 00             	movzbl (%eax),%eax
 173:	84 c0                	test   %al,%al
 175:	75 e2                	jne    159 <strchr+0xe>
  return 0;
 177:	b8 00 00 00 00       	mov    $0x0,%eax
}
 17c:	c9                   	leave
 17d:	c3                   	ret

0000017e <gets>:

char*
gets(char *buf, int max)
{
 17e:	55                   	push   %ebp
 17f:	89 e5                	mov    %esp,%ebp
 181:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 184:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 18b:	eb 42                	jmp    1cf <gets+0x51>
    cc = read(0, &c, 1);
 18d:	83 ec 04             	sub    $0x4,%esp
 190:	6a 01                	push   $0x1
 192:	8d 45 ef             	lea    -0x11(%ebp),%eax
 195:	50                   	push   %eax
 196:	6a 00                	push   $0x0
 198:	e8 47 01 00 00       	call   2e4 <read>
 19d:	83 c4 10             	add    $0x10,%esp
 1a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1a3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1a7:	7e 33                	jle    1dc <gets+0x5e>
      break;
    buf[i++] = c;
 1a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ac:	8d 50 01             	lea    0x1(%eax),%edx
 1af:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1b2:	89 c2                	mov    %eax,%edx
 1b4:	8b 45 08             	mov    0x8(%ebp),%eax
 1b7:	01 c2                	add    %eax,%edx
 1b9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1bd:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1bf:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c3:	3c 0a                	cmp    $0xa,%al
 1c5:	74 16                	je     1dd <gets+0x5f>
 1c7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1cb:	3c 0d                	cmp    $0xd,%al
 1cd:	74 0e                	je     1dd <gets+0x5f>
  for(i=0; i+1 < max; ){
 1cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1d2:	83 c0 01             	add    $0x1,%eax
 1d5:	39 45 0c             	cmp    %eax,0xc(%ebp)
 1d8:	7f b3                	jg     18d <gets+0xf>
 1da:	eb 01                	jmp    1dd <gets+0x5f>
      break;
 1dc:	90                   	nop
      break;
  }
  buf[i] = '\0';
 1dd:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1e0:	8b 45 08             	mov    0x8(%ebp),%eax
 1e3:	01 d0                	add    %edx,%eax
 1e5:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1e8:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1eb:	c9                   	leave
 1ec:	c3                   	ret

000001ed <stat>:

int
stat(char *n, struct stat *st)
{
 1ed:	55                   	push   %ebp
 1ee:	89 e5                	mov    %esp,%ebp
 1f0:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f3:	83 ec 08             	sub    $0x8,%esp
 1f6:	6a 00                	push   $0x0
 1f8:	ff 75 08             	push   0x8(%ebp)
 1fb:	e8 0c 01 00 00       	call   30c <open>
 200:	83 c4 10             	add    $0x10,%esp
 203:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 206:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 20a:	79 07                	jns    213 <stat+0x26>
    return -1;
 20c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 211:	eb 25                	jmp    238 <stat+0x4b>
  r = fstat(fd, st);
 213:	83 ec 08             	sub    $0x8,%esp
 216:	ff 75 0c             	push   0xc(%ebp)
 219:	ff 75 f4             	push   -0xc(%ebp)
 21c:	e8 03 01 00 00       	call   324 <fstat>
 221:	83 c4 10             	add    $0x10,%esp
 224:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 227:	83 ec 0c             	sub    $0xc,%esp
 22a:	ff 75 f4             	push   -0xc(%ebp)
 22d:	e8 c2 00 00 00       	call   2f4 <close>
 232:	83 c4 10             	add    $0x10,%esp
  return r;
 235:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 238:	c9                   	leave
 239:	c3                   	ret

0000023a <atoi>:

int
atoi(const char *s)
{
 23a:	55                   	push   %ebp
 23b:	89 e5                	mov    %esp,%ebp
 23d:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 240:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 247:	eb 25                	jmp    26e <atoi+0x34>
    n = n*10 + *s++ - '0';
 249:	8b 55 fc             	mov    -0x4(%ebp),%edx
 24c:	89 d0                	mov    %edx,%eax
 24e:	c1 e0 02             	shl    $0x2,%eax
 251:	01 d0                	add    %edx,%eax
 253:	01 c0                	add    %eax,%eax
 255:	89 c1                	mov    %eax,%ecx
 257:	8b 45 08             	mov    0x8(%ebp),%eax
 25a:	8d 50 01             	lea    0x1(%eax),%edx
 25d:	89 55 08             	mov    %edx,0x8(%ebp)
 260:	0f b6 00             	movzbl (%eax),%eax
 263:	0f be c0             	movsbl %al,%eax
 266:	01 c8                	add    %ecx,%eax
 268:	83 e8 30             	sub    $0x30,%eax
 26b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 26e:	8b 45 08             	mov    0x8(%ebp),%eax
 271:	0f b6 00             	movzbl (%eax),%eax
 274:	3c 2f                	cmp    $0x2f,%al
 276:	7e 0a                	jle    282 <atoi+0x48>
 278:	8b 45 08             	mov    0x8(%ebp),%eax
 27b:	0f b6 00             	movzbl (%eax),%eax
 27e:	3c 39                	cmp    $0x39,%al
 280:	7e c7                	jle    249 <atoi+0xf>
  return n;
 282:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 285:	c9                   	leave
 286:	c3                   	ret

00000287 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 287:	55                   	push   %ebp
 288:	89 e5                	mov    %esp,%ebp
 28a:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 28d:	8b 45 08             	mov    0x8(%ebp),%eax
 290:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 293:	8b 45 0c             	mov    0xc(%ebp),%eax
 296:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 299:	eb 17                	jmp    2b2 <memmove+0x2b>
    *dst++ = *src++;
 29b:	8b 55 f8             	mov    -0x8(%ebp),%edx
 29e:	8d 42 01             	lea    0x1(%edx),%eax
 2a1:	89 45 f8             	mov    %eax,-0x8(%ebp)
 2a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2a7:	8d 48 01             	lea    0x1(%eax),%ecx
 2aa:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 2ad:	0f b6 12             	movzbl (%edx),%edx
 2b0:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 2b2:	8b 45 10             	mov    0x10(%ebp),%eax
 2b5:	8d 50 ff             	lea    -0x1(%eax),%edx
 2b8:	89 55 10             	mov    %edx,0x10(%ebp)
 2bb:	85 c0                	test   %eax,%eax
 2bd:	7f dc                	jg     29b <memmove+0x14>
  return vdst;
 2bf:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2c2:	c9                   	leave
 2c3:	c3                   	ret

000002c4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2c4:	b8 01 00 00 00       	mov    $0x1,%eax
 2c9:	cd 40                	int    $0x40
 2cb:	c3                   	ret

000002cc <exit>:
SYSCALL(exit)
 2cc:	b8 02 00 00 00       	mov    $0x2,%eax
 2d1:	cd 40                	int    $0x40
 2d3:	c3                   	ret

000002d4 <wait>:
SYSCALL(wait)
 2d4:	b8 03 00 00 00       	mov    $0x3,%eax
 2d9:	cd 40                	int    $0x40
 2db:	c3                   	ret

000002dc <pipe>:
SYSCALL(pipe)
 2dc:	b8 04 00 00 00       	mov    $0x4,%eax
 2e1:	cd 40                	int    $0x40
 2e3:	c3                   	ret

000002e4 <read>:
SYSCALL(read)
 2e4:	b8 05 00 00 00       	mov    $0x5,%eax
 2e9:	cd 40                	int    $0x40
 2eb:	c3                   	ret

000002ec <write>:
SYSCALL(write)
 2ec:	b8 10 00 00 00       	mov    $0x10,%eax
 2f1:	cd 40                	int    $0x40
 2f3:	c3                   	ret

000002f4 <close>:
SYSCALL(close)
 2f4:	b8 15 00 00 00       	mov    $0x15,%eax
 2f9:	cd 40                	int    $0x40
 2fb:	c3                   	ret

000002fc <kill>:
SYSCALL(kill)
 2fc:	b8 06 00 00 00       	mov    $0x6,%eax
 301:	cd 40                	int    $0x40
 303:	c3                   	ret

00000304 <exec>:
SYSCALL(exec)
 304:	b8 07 00 00 00       	mov    $0x7,%eax
 309:	cd 40                	int    $0x40
 30b:	c3                   	ret

0000030c <open>:
SYSCALL(open)
 30c:	b8 0f 00 00 00       	mov    $0xf,%eax
 311:	cd 40                	int    $0x40
 313:	c3                   	ret

00000314 <mknod>:
SYSCALL(mknod)
 314:	b8 11 00 00 00       	mov    $0x11,%eax
 319:	cd 40                	int    $0x40
 31b:	c3                   	ret

0000031c <unlink>:
SYSCALL(unlink)
 31c:	b8 12 00 00 00       	mov    $0x12,%eax
 321:	cd 40                	int    $0x40
 323:	c3                   	ret

00000324 <fstat>:
SYSCALL(fstat)
 324:	b8 08 00 00 00       	mov    $0x8,%eax
 329:	cd 40                	int    $0x40
 32b:	c3                   	ret

0000032c <link>:
SYSCALL(link)
 32c:	b8 13 00 00 00       	mov    $0x13,%eax
 331:	cd 40                	int    $0x40
 333:	c3                   	ret

00000334 <mkdir>:
SYSCALL(mkdir)
 334:	b8 14 00 00 00       	mov    $0x14,%eax
 339:	cd 40                	int    $0x40
 33b:	c3                   	ret

0000033c <chdir>:
SYSCALL(chdir)
 33c:	b8 09 00 00 00       	mov    $0x9,%eax
 341:	cd 40                	int    $0x40
 343:	c3                   	ret

00000344 <dup>:
SYSCALL(dup)
 344:	b8 0a 00 00 00       	mov    $0xa,%eax
 349:	cd 40                	int    $0x40
 34b:	c3                   	ret

0000034c <getpid>:
SYSCALL(getpid)
 34c:	b8 0b 00 00 00       	mov    $0xb,%eax
 351:	cd 40                	int    $0x40
 353:	c3                   	ret

00000354 <sbrk>:
SYSCALL(sbrk)
 354:	b8 0c 00 00 00       	mov    $0xc,%eax
 359:	cd 40                	int    $0x40
 35b:	c3                   	ret

0000035c <sleep>:
SYSCALL(sleep)
 35c:	b8 0d 00 00 00       	mov    $0xd,%eax
 361:	cd 40                	int    $0x40
 363:	c3                   	ret

00000364 <uptime>:
SYSCALL(uptime)
 364:	b8 0e 00 00 00       	mov    $0xe,%eax
 369:	cd 40                	int    $0x40
 36b:	c3                   	ret

0000036c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 36c:	55                   	push   %ebp
 36d:	89 e5                	mov    %esp,%ebp
 36f:	83 ec 18             	sub    $0x18,%esp
 372:	8b 45 0c             	mov    0xc(%ebp),%eax
 375:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 378:	83 ec 04             	sub    $0x4,%esp
 37b:	6a 01                	push   $0x1
 37d:	8d 45 f4             	lea    -0xc(%ebp),%eax
 380:	50                   	push   %eax
 381:	ff 75 08             	push   0x8(%ebp)
 384:	e8 63 ff ff ff       	call   2ec <write>
 389:	83 c4 10             	add    $0x10,%esp
}
 38c:	90                   	nop
 38d:	c9                   	leave
 38e:	c3                   	ret

0000038f <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 38f:	55                   	push   %ebp
 390:	89 e5                	mov    %esp,%ebp
 392:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 395:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 39c:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3a0:	74 17                	je     3b9 <printint+0x2a>
 3a2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3a6:	79 11                	jns    3b9 <printint+0x2a>
    neg = 1;
 3a8:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3af:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b2:	f7 d8                	neg    %eax
 3b4:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3b7:	eb 06                	jmp    3bf <printint+0x30>
  } else {
    x = xx;
 3b9:	8b 45 0c             	mov    0xc(%ebp),%eax
 3bc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3bf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3c6:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3c9:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3cc:	ba 00 00 00 00       	mov    $0x0,%edx
 3d1:	f7 f1                	div    %ecx
 3d3:	89 d1                	mov    %edx,%ecx
 3d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3d8:	8d 50 01             	lea    0x1(%eax),%edx
 3db:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3de:	0f b6 91 74 0a 00 00 	movzbl 0xa74(%ecx),%edx
 3e5:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 3e9:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3ec:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3ef:	ba 00 00 00 00       	mov    $0x0,%edx
 3f4:	f7 f1                	div    %ecx
 3f6:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3f9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3fd:	75 c7                	jne    3c6 <printint+0x37>
  if(neg)
 3ff:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 403:	74 2d                	je     432 <printint+0xa3>
    buf[i++] = '-';
 405:	8b 45 f4             	mov    -0xc(%ebp),%eax
 408:	8d 50 01             	lea    0x1(%eax),%edx
 40b:	89 55 f4             	mov    %edx,-0xc(%ebp)
 40e:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 413:	eb 1d                	jmp    432 <printint+0xa3>
    putc(fd, buf[i]);
 415:	8d 55 dc             	lea    -0x24(%ebp),%edx
 418:	8b 45 f4             	mov    -0xc(%ebp),%eax
 41b:	01 d0                	add    %edx,%eax
 41d:	0f b6 00             	movzbl (%eax),%eax
 420:	0f be c0             	movsbl %al,%eax
 423:	83 ec 08             	sub    $0x8,%esp
 426:	50                   	push   %eax
 427:	ff 75 08             	push   0x8(%ebp)
 42a:	e8 3d ff ff ff       	call   36c <putc>
 42f:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 432:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 436:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 43a:	79 d9                	jns    415 <printint+0x86>
}
 43c:	90                   	nop
 43d:	90                   	nop
 43e:	c9                   	leave
 43f:	c3                   	ret

00000440 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 446:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 44d:	8d 45 0c             	lea    0xc(%ebp),%eax
 450:	83 c0 04             	add    $0x4,%eax
 453:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 456:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 45d:	e9 59 01 00 00       	jmp    5bb <printf+0x17b>
    c = fmt[i] & 0xff;
 462:	8b 55 0c             	mov    0xc(%ebp),%edx
 465:	8b 45 f0             	mov    -0x10(%ebp),%eax
 468:	01 d0                	add    %edx,%eax
 46a:	0f b6 00             	movzbl (%eax),%eax
 46d:	0f be c0             	movsbl %al,%eax
 470:	25 ff 00 00 00       	and    $0xff,%eax
 475:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 478:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 47c:	75 2c                	jne    4aa <printf+0x6a>
      if(c == '%'){
 47e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 482:	75 0c                	jne    490 <printf+0x50>
        state = '%';
 484:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 48b:	e9 27 01 00 00       	jmp    5b7 <printf+0x177>
      } else {
        putc(fd, c);
 490:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 493:	0f be c0             	movsbl %al,%eax
 496:	83 ec 08             	sub    $0x8,%esp
 499:	50                   	push   %eax
 49a:	ff 75 08             	push   0x8(%ebp)
 49d:	e8 ca fe ff ff       	call   36c <putc>
 4a2:	83 c4 10             	add    $0x10,%esp
 4a5:	e9 0d 01 00 00       	jmp    5b7 <printf+0x177>
      }
    } else if(state == '%'){
 4aa:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4ae:	0f 85 03 01 00 00    	jne    5b7 <printf+0x177>
      if(c == 'd'){
 4b4:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4b8:	75 1e                	jne    4d8 <printf+0x98>
        printint(fd, *ap, 10, 1);
 4ba:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4bd:	8b 00                	mov    (%eax),%eax
 4bf:	6a 01                	push   $0x1
 4c1:	6a 0a                	push   $0xa
 4c3:	50                   	push   %eax
 4c4:	ff 75 08             	push   0x8(%ebp)
 4c7:	e8 c3 fe ff ff       	call   38f <printint>
 4cc:	83 c4 10             	add    $0x10,%esp
        ap++;
 4cf:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4d3:	e9 d8 00 00 00       	jmp    5b0 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 4d8:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4dc:	74 06                	je     4e4 <printf+0xa4>
 4de:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4e2:	75 1e                	jne    502 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 4e4:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4e7:	8b 00                	mov    (%eax),%eax
 4e9:	6a 00                	push   $0x0
 4eb:	6a 10                	push   $0x10
 4ed:	50                   	push   %eax
 4ee:	ff 75 08             	push   0x8(%ebp)
 4f1:	e8 99 fe ff ff       	call   38f <printint>
 4f6:	83 c4 10             	add    $0x10,%esp
        ap++;
 4f9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4fd:	e9 ae 00 00 00       	jmp    5b0 <printf+0x170>
      } else if(c == 's'){
 502:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 506:	75 43                	jne    54b <printf+0x10b>
        s = (char*)*ap;
 508:	8b 45 e8             	mov    -0x18(%ebp),%eax
 50b:	8b 00                	mov    (%eax),%eax
 50d:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 510:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 514:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 518:	75 25                	jne    53f <printf+0xff>
          s = "(null)";
 51a:	c7 45 f4 24 08 00 00 	movl   $0x824,-0xc(%ebp)
        while(*s != 0){
 521:	eb 1c                	jmp    53f <printf+0xff>
          putc(fd, *s);
 523:	8b 45 f4             	mov    -0xc(%ebp),%eax
 526:	0f b6 00             	movzbl (%eax),%eax
 529:	0f be c0             	movsbl %al,%eax
 52c:	83 ec 08             	sub    $0x8,%esp
 52f:	50                   	push   %eax
 530:	ff 75 08             	push   0x8(%ebp)
 533:	e8 34 fe ff ff       	call   36c <putc>
 538:	83 c4 10             	add    $0x10,%esp
          s++;
 53b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 53f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 542:	0f b6 00             	movzbl (%eax),%eax
 545:	84 c0                	test   %al,%al
 547:	75 da                	jne    523 <printf+0xe3>
 549:	eb 65                	jmp    5b0 <printf+0x170>
        }
      } else if(c == 'c'){
 54b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 54f:	75 1d                	jne    56e <printf+0x12e>
        putc(fd, *ap);
 551:	8b 45 e8             	mov    -0x18(%ebp),%eax
 554:	8b 00                	mov    (%eax),%eax
 556:	0f be c0             	movsbl %al,%eax
 559:	83 ec 08             	sub    $0x8,%esp
 55c:	50                   	push   %eax
 55d:	ff 75 08             	push   0x8(%ebp)
 560:	e8 07 fe ff ff       	call   36c <putc>
 565:	83 c4 10             	add    $0x10,%esp
        ap++;
 568:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 56c:	eb 42                	jmp    5b0 <printf+0x170>
      } else if(c == '%'){
 56e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 572:	75 17                	jne    58b <printf+0x14b>
        putc(fd, c);
 574:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 577:	0f be c0             	movsbl %al,%eax
 57a:	83 ec 08             	sub    $0x8,%esp
 57d:	50                   	push   %eax
 57e:	ff 75 08             	push   0x8(%ebp)
 581:	e8 e6 fd ff ff       	call   36c <putc>
 586:	83 c4 10             	add    $0x10,%esp
 589:	eb 25                	jmp    5b0 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 58b:	83 ec 08             	sub    $0x8,%esp
 58e:	6a 25                	push   $0x25
 590:	ff 75 08             	push   0x8(%ebp)
 593:	e8 d4 fd ff ff       	call   36c <putc>
 598:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 59b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 59e:	0f be c0             	movsbl %al,%eax
 5a1:	83 ec 08             	sub    $0x8,%esp
 5a4:	50                   	push   %eax
 5a5:	ff 75 08             	push   0x8(%ebp)
 5a8:	e8 bf fd ff ff       	call   36c <putc>
 5ad:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5b0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 5b7:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5bb:	8b 55 0c             	mov    0xc(%ebp),%edx
 5be:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5c1:	01 d0                	add    %edx,%eax
 5c3:	0f b6 00             	movzbl (%eax),%eax
 5c6:	84 c0                	test   %al,%al
 5c8:	0f 85 94 fe ff ff    	jne    462 <printf+0x22>
    }
  }
}
 5ce:	90                   	nop
 5cf:	90                   	nop
 5d0:	c9                   	leave
 5d1:	c3                   	ret

000005d2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5d2:	55                   	push   %ebp
 5d3:	89 e5                	mov    %esp,%ebp
 5d5:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5d8:	8b 45 08             	mov    0x8(%ebp),%eax
 5db:	83 e8 08             	sub    $0x8,%eax
 5de:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e1:	a1 90 0a 00 00       	mov    0xa90,%eax
 5e6:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5e9:	eb 24                	jmp    60f <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5ee:	8b 00                	mov    (%eax),%eax
 5f0:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 5f3:	72 12                	jb     607 <free+0x35>
 5f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5f8:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 5fb:	72 24                	jb     621 <free+0x4f>
 5fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 600:	8b 00                	mov    (%eax),%eax
 602:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 605:	72 1a                	jb     621 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 607:	8b 45 fc             	mov    -0x4(%ebp),%eax
 60a:	8b 00                	mov    (%eax),%eax
 60c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 60f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 612:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 615:	73 d4                	jae    5eb <free+0x19>
 617:	8b 45 fc             	mov    -0x4(%ebp),%eax
 61a:	8b 00                	mov    (%eax),%eax
 61c:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 61f:	73 ca                	jae    5eb <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 621:	8b 45 f8             	mov    -0x8(%ebp),%eax
 624:	8b 40 04             	mov    0x4(%eax),%eax
 627:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 62e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 631:	01 c2                	add    %eax,%edx
 633:	8b 45 fc             	mov    -0x4(%ebp),%eax
 636:	8b 00                	mov    (%eax),%eax
 638:	39 c2                	cmp    %eax,%edx
 63a:	75 24                	jne    660 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 63c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 63f:	8b 50 04             	mov    0x4(%eax),%edx
 642:	8b 45 fc             	mov    -0x4(%ebp),%eax
 645:	8b 00                	mov    (%eax),%eax
 647:	8b 40 04             	mov    0x4(%eax),%eax
 64a:	01 c2                	add    %eax,%edx
 64c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 64f:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 652:	8b 45 fc             	mov    -0x4(%ebp),%eax
 655:	8b 00                	mov    (%eax),%eax
 657:	8b 10                	mov    (%eax),%edx
 659:	8b 45 f8             	mov    -0x8(%ebp),%eax
 65c:	89 10                	mov    %edx,(%eax)
 65e:	eb 0a                	jmp    66a <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 660:	8b 45 fc             	mov    -0x4(%ebp),%eax
 663:	8b 10                	mov    (%eax),%edx
 665:	8b 45 f8             	mov    -0x8(%ebp),%eax
 668:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 66a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66d:	8b 40 04             	mov    0x4(%eax),%eax
 670:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 677:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67a:	01 d0                	add    %edx,%eax
 67c:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 67f:	75 20                	jne    6a1 <free+0xcf>
    p->s.size += bp->s.size;
 681:	8b 45 fc             	mov    -0x4(%ebp),%eax
 684:	8b 50 04             	mov    0x4(%eax),%edx
 687:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68a:	8b 40 04             	mov    0x4(%eax),%eax
 68d:	01 c2                	add    %eax,%edx
 68f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 692:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 695:	8b 45 f8             	mov    -0x8(%ebp),%eax
 698:	8b 10                	mov    (%eax),%edx
 69a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69d:	89 10                	mov    %edx,(%eax)
 69f:	eb 08                	jmp    6a9 <free+0xd7>
  } else
    p->s.ptr = bp;
 6a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a4:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6a7:	89 10                	mov    %edx,(%eax)
  freep = p;
 6a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ac:	a3 90 0a 00 00       	mov    %eax,0xa90
}
 6b1:	90                   	nop
 6b2:	c9                   	leave
 6b3:	c3                   	ret

000006b4 <morecore>:

static Header*
morecore(uint nu)
{
 6b4:	55                   	push   %ebp
 6b5:	89 e5                	mov    %esp,%ebp
 6b7:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6ba:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6c1:	77 07                	ja     6ca <morecore+0x16>
    nu = 4096;
 6c3:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6ca:	8b 45 08             	mov    0x8(%ebp),%eax
 6cd:	c1 e0 03             	shl    $0x3,%eax
 6d0:	83 ec 0c             	sub    $0xc,%esp
 6d3:	50                   	push   %eax
 6d4:	e8 7b fc ff ff       	call   354 <sbrk>
 6d9:	83 c4 10             	add    $0x10,%esp
 6dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6df:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6e3:	75 07                	jne    6ec <morecore+0x38>
    return 0;
 6e5:	b8 00 00 00 00       	mov    $0x0,%eax
 6ea:	eb 26                	jmp    712 <morecore+0x5e>
  hp = (Header*)p;
 6ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6f5:	8b 55 08             	mov    0x8(%ebp),%edx
 6f8:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6fe:	83 c0 08             	add    $0x8,%eax
 701:	83 ec 0c             	sub    $0xc,%esp
 704:	50                   	push   %eax
 705:	e8 c8 fe ff ff       	call   5d2 <free>
 70a:	83 c4 10             	add    $0x10,%esp
  return freep;
 70d:	a1 90 0a 00 00       	mov    0xa90,%eax
}
 712:	c9                   	leave
 713:	c3                   	ret

00000714 <malloc>:

void*
malloc(uint nbytes)
{
 714:	55                   	push   %ebp
 715:	89 e5                	mov    %esp,%ebp
 717:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 71a:	8b 45 08             	mov    0x8(%ebp),%eax
 71d:	83 c0 07             	add    $0x7,%eax
 720:	c1 e8 03             	shr    $0x3,%eax
 723:	83 c0 01             	add    $0x1,%eax
 726:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 729:	a1 90 0a 00 00       	mov    0xa90,%eax
 72e:	89 45 f0             	mov    %eax,-0x10(%ebp)
 731:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 735:	75 23                	jne    75a <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 737:	c7 45 f0 88 0a 00 00 	movl   $0xa88,-0x10(%ebp)
 73e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 741:	a3 90 0a 00 00       	mov    %eax,0xa90
 746:	a1 90 0a 00 00       	mov    0xa90,%eax
 74b:	a3 88 0a 00 00       	mov    %eax,0xa88
    base.s.size = 0;
 750:	c7 05 8c 0a 00 00 00 	movl   $0x0,0xa8c
 757:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 75a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 75d:	8b 00                	mov    (%eax),%eax
 75f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 762:	8b 45 f4             	mov    -0xc(%ebp),%eax
 765:	8b 40 04             	mov    0x4(%eax),%eax
 768:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 76b:	72 4d                	jb     7ba <malloc+0xa6>
      if(p->s.size == nunits)
 76d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 770:	8b 40 04             	mov    0x4(%eax),%eax
 773:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 776:	75 0c                	jne    784 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 778:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77b:	8b 10                	mov    (%eax),%edx
 77d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 780:	89 10                	mov    %edx,(%eax)
 782:	eb 26                	jmp    7aa <malloc+0x96>
      else {
        p->s.size -= nunits;
 784:	8b 45 f4             	mov    -0xc(%ebp),%eax
 787:	8b 40 04             	mov    0x4(%eax),%eax
 78a:	2b 45 ec             	sub    -0x14(%ebp),%eax
 78d:	89 c2                	mov    %eax,%edx
 78f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 792:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 795:	8b 45 f4             	mov    -0xc(%ebp),%eax
 798:	8b 40 04             	mov    0x4(%eax),%eax
 79b:	c1 e0 03             	shl    $0x3,%eax
 79e:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a4:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7a7:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ad:	a3 90 0a 00 00       	mov    %eax,0xa90
      return (void*)(p + 1);
 7b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b5:	83 c0 08             	add    $0x8,%eax
 7b8:	eb 3b                	jmp    7f5 <malloc+0xe1>
    }
    if(p == freep)
 7ba:	a1 90 0a 00 00       	mov    0xa90,%eax
 7bf:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7c2:	75 1e                	jne    7e2 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7c4:	83 ec 0c             	sub    $0xc,%esp
 7c7:	ff 75 ec             	push   -0x14(%ebp)
 7ca:	e8 e5 fe ff ff       	call   6b4 <morecore>
 7cf:	83 c4 10             	add    $0x10,%esp
 7d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7d5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7d9:	75 07                	jne    7e2 <malloc+0xce>
        return 0;
 7db:	b8 00 00 00 00       	mov    $0x0,%eax
 7e0:	eb 13                	jmp    7f5 <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7eb:	8b 00                	mov    (%eax),%eax
 7ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7f0:	e9 6d ff ff ff       	jmp    762 <malloc+0x4e>
  }
}
 7f5:	c9                   	leave
 7f6:	c3                   	ret
