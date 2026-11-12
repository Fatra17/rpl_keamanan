import 'package:flutter_test/flutter_test.dart';
import 'package:rpl_keamanan/utils/validators.dart';

void main() {
  group('Validators Test', () {
    test('isValidEmail mengembalikan true untuk email valid dan false jika tidak', () {
      expect(Validators.isValidEmail('user@example.com'), isTrue);
      expect(Validators.isValidEmail('user.name@amikom.ac.id'), isTrue);
      expect(Validators.isValidEmail('invalid-email'), isFalse);
      expect(Validators.isValidEmail('user@domain'), isFalse);
    });

    test('sanitize membersihkan karakter berbahaya HTML/XSS', () {
      const input = '<script>alert("xss")</script>\'';
      final result = Validators.sanitize(input);

      expect(result, '&lt;script&gt;alert(&quot;xss&quot;)&lt;/script&gt;&#39;');
    });

    test('validateText memvalidasi input kosong dan rentang panjang', () {
      expect(
        Validators.validateText('', fieldName: 'Nama'),
        'Nama tidak boleh kosong',
      );
      expect(
        Validators.validateText('Ab', fieldName: 'Nama', minLength: 3, maxLength: 10),
        'Nama harus antara 3-10 karakter',
      );
      expect(
        Validators.validateText('Andi', fieldName: 'Nama', minLength: 3, maxLength: 10),
        isNull,
      );
    });

    test('validatePhone memvalidasi 10-13 digit angka', () {
      expect(Validators.validatePhone('081234567890'), isNull);
      expect(Validators.validatePhone('08123'), isNotNull);
      expect(Validators.validatePhone('0812345abcde'), isNotNull);
    });

    test('validateUrl memvalidasi awalan http:// atau https://', () {
      expect(Validators.validateUrl('https://amikom.ac.id'), isNull);
      expect(Validators.validateUrl('http://example.com'), isNull);
      expect(Validators.validateUrl('www.example.com'), isNotNull);
    });

    test('validatePassword memvalidasi panjang, huruf kapital, angka, dan simbol', () {
      expect(Validators.validatePassword('Pass@1234'), isNull);
      expect(Validators.validatePassword('pass1234'), isNotNull);
      expect(Validators.validatePassword('Pass1234'), isNotNull);
      expect(Validators.validatePassword('Pa@1'), isNotNull);
    });
  });
}