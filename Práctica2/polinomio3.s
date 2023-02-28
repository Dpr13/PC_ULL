# Programa para evaluar polinomio tercer grado

##include <iostream>
#int main(void) {
#  float a,b,c,d;
#  std::cout << "\nEvaluacion polinomio f(x) = a x^3  + b x^2 + c x + d  en un intervalo [r,s]\n";
#  std::cout << "\nIntroduzca los valores de a,b,c y d (separados por retorno de carro):\n";
#  std::cin >> a;
#  std::cin >> b;
#  std::cin >> c;
#  std::cin >> d;
#  int r,s;
#  do {
#    std::cout << "Introduzca [r,s] (r y s enteros, r <= s)  (separados por retorno de carro):\n";
#    std::cin >> r;
#    std::cin >> s;
#  } while (r > s);
#  for (int x = r ; x <= s ; x++) {
#    float f = a*x*x*x + b*x*x + c*x + d;
#    if (f >= 2.1) {
#      std::cout << "\nf(" << x << ") = " << f;
#    }
#  }
#  std::cout << "\n\nTermina el programa\n";
#}
	.data
strEvalPol:	.asciiz "\nEvaluacion polinomio f(x) = a x^3  + b x^2 + c x + d  en un intervalo [r,s]\n"
strIntroVal:	.asciiz "\nIntroduzca los valores de a,b,c y d (separados por retorno de carro):\n"
strRyS:		.asciiz "Introduzca [r,s] (r y s enteros, r <= s)  (separados por retorno de carro):\n"
strPrimerPar:	.asciiz "\nf("
strSegundoPar:	.asciiz ") = "
strFinPrograma:	.asciiz "\n\nTermina el programa\n"

	.text
#a : $f20
#b : $f22
#c : $f24
#d : $f26
#r : $s0
#s : $s1
#x : $s2
#f : $f28

#int main(void) {
main:
#  std::cout << "\nEvaluacion polinomio f(x) = a x^3  + b x^2 + c x + d  en un intervalo [r,s]\n";
	li $v0,4
	la $a0,strEvalPol
	syscall
#  std::cout << "\nIntroduzca los valores de a,b,c y d (separados por retorno de carro):\n";
	li $v0,4
	la $a0,strIntroVal
	syscall
#  std::cin >> a;
	li $v0,6
	syscall
	mov.d $f20, $f0 
#  std::cin >> b;
	li $v0,6
	syscall
	mov.d $f22, $f0 
#  std::cin >> c;
	li $v0,6
	syscall
	mov.d $f24, $f0 
#  std::cin >> d;
	li $v0,6
	syscall
	mov.d $f26, $f0 
#  do {
do_while:
#    std::cout << "Introduzca [r,s] (r y s enteros, r <= s)  (separados por retorno de carro):\n";
	li $v0,4
	la $a0,strRyS
	syscall
#    std::cin >> r;
	li	$v0,5
	syscall
	move	$s0,$v0
#    std::cin >> s;
	li	$v0,5
	syscall
	move	$s1,$v0
#  } while (r > s);
	bgt $s0, $s1,for_fin
#  for (int x = r ; x <= s ; x++) {
	move $s2, $s0
for:
#    float f = a*x*x*x + b*x*x + c*x + d;
	mtc1 $s2,$f0
	cvt.s.w $f0,$f0
	mul.s $f4,$f0,$f0 #f4 = x*x
	mul.s $f6,$f4,$f0 #f6 = x*x*x
	mul.s $f8,$f6,$f20 #f8 = x*x*x*a
	mul.s $f10,$f22,$f4 #f10 = x*x*b
	mul.s $f16,$f24,$f0 #f16 = x*c
	add.s $f4,$f8,$f10 #f4 = x*x*b + x*x*x*a
	add.s $f4,$f16,$f4 #f4 = x*x*b + x*x*x*a + x*c
	add.s $f4,$f26,$f4 #f4 = x*x*b + x*x*x*a + x*c + d
	mov.s $f28, $f4
#    if (f >= 2.1) {
if_float:
	li.s $f6,2.1
	c.lt.s $f28,$f6
	bc1t if_float_fin
#      std::cout << "\nf(" << x << ") = " << f;
	li $v0,4
	la $a0,strPrimerPar
	syscall
	li $v0,1
	move $a0,$s2
	syscall
	li $v0,4
	la $a0,strSegundoPar
	syscall
	li $v0,2
	mov.s $f12,$f28
	syscall
	bgt $s2, $s1, for_fin
	addi $s2,1
	b for
if_float_fin:
	bgt $s2, $s1, for_fin
	addi $s2,1
	b for
for_fin:
#  std::cout << "\n\nTermina el programa\n";
	li	$v0,4
	la	$a0,strFinPrograma
	syscall
#}
	li	$v0,10
	syscall
