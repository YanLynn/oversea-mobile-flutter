import 'package:borderlessWorking/data/api/apis.dart';
import 'package:borderlessWorking/screens/auth/drawerBar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;

class TermsPage extends StatelessWidget {
  const TermsPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('利用規約', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Style.CustomColor.mainColor,        
      ),
      drawer: MyDrawer(Apis.profileImg, Apis.userName),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                bottom: 15, // Space between underline and text
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "利用規約",
                  style: Style.Customstyles.h1,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 15.0),
              child: Text(
                'ボーダレスワーキングのご利用に際しては、本サイト利用規約をお読みください。\n' +
                    '本規約は、株式会社 TrustGrowth が提供するサイト上のコンテンツ、サービス、情報に適用されます。\n\n' +
                    '※ボーダレスワーキングは運営国である日本の法令に準拠して運営されており、日本国以外のいかなる国や地域に関しても、当該国や地域の適用される法令に適合していることを保証するものではありません。ユーザーは、ボーダレスワーキングへのアクセスおよび利用にあたり、その責任において、ユーザー自身に適用される国または地域の法令を遵守しなければならないものとします。',
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("ボーダレスワーキングの利用")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            '「ボーダレスワーキング」とは、株式会社 TrustGrowth が提供するインターネット上の転職のための求人情報サイト',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: '（https://borderless-working.jp）',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).popAndPushNamed('/');
                          },
                      ),
                      TextSpan(
                        text: 'やその関連サイト、および当該サイトに付随する電子メール配信その他の転職支援サービスの総称をいいます。\n' +
                            '「ユーザー」とは、ボーダレスワーキング上の求人情報を提供した企業団体やボーダレスワーキングに登録したメンバー、またはボーダレスワーキングの全てのサービスの利用者の総称をいいます。\n' +
                            'ユーザーは、自らの意思と責任のもと、ボーダレスワーキングをご利用ください。また、利用に関わるすべての責任はユーザーが負うものとします。\n' +
                            'ボーダレスワーキングが提供するサービスは、利用者が本利用規約の内容すべてに承諾することを条件として提供されます。当サイトのサービスをご利用いただくことによって、ユーザーは本規約を承諾いただいたものとみなします。',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("会員について")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('「会員」とは、ボーダレスワーキングに登録し、株式会社 TrustGrowth がこれを承認した方をいいます。会員は求職者会員と企業会員の 2 種類があります。\n' +
                    '会員は、登録の時点で本規約の内容を承認したものとみなします\n' +
                    '会員は、ボーダレスワーキングサイトの会員管理画面において、会員登録の際に入力した情報を、いつでも確認・変更・追加・削除する事ができます。\n' +
                    '会員は、ボーダレスワーキングサイトの会員管理画面において、自ら会員登録の抹消を行う事ができます。\n' +
                    '会員が自ら会員登録の抹消を行わない場合、または、抹消を希望しない場合であっても、会員登録後の 3 年間に会員管理画面に 1 回もログインしない場合には、その会員登録が抹消される場合があります。\n' +
                    '株式会社 TrustGrowth は、会員が本規約に違反したと株式会社 TrustGrowth が判断した場合は、会員に事前に通知することなく、会員向けサービスの提供を一時中止、または除名することができます。'),
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("個人情報の取り扱い")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(
                "株式会社 TrustGrowth の個人情報の取り扱い方針につきましては、「プライバシーポリシー」をご覧ください。",
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("禁止事項")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 15.0),
              child: Text(
                'ボーダレスワーキングの目的は、求職者会員においてはその求職活動を助け、一方企業会員においては適切な人材を見つけるための支援を行うことであり、その目的を故意に妨げるいかなる行為も禁止されます。\n' +
                    '株式会社 TrustGrowth は、何をもってサイトの使用を妨害する行為であるかを独自に判断する権利を有し、禁止される行為に違反したユーザーに対してボーダレスワーキングの利用を停止する判断を単独で下す権利を有します。\n' +
                    '以下は、禁止される行為の例ですが、禁止される行為は以下に限るものではありません。',
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('・虚偽の情報を登録する、または提供する行為\n' +
                    '・著作権、商標権、プライバシー権、肖像権、名誉、財産、その他知的所有権を侵害する行為。 個人や団体を誹謗中傷する行為。\n' +
                    '・法令、公序良俗に反する行為、またはその恐れのある行為。反社会的な行為。\n' +
                    '・運営を妨げ、あるいは株式会社 TrustGrowth の信用を毀損するような行為、またはその恐れのある行為。\n' +
                    '・サービスを通じて入手した情報を、複製、販売、出版、その他私的利用の範囲を超えて使用する行為。商業目的や不法な目的に使用、または、提供する行為。' +
                    '・正当な権限無く、ユーザーのシステム認証およびセキュリティの探求、侵害する行為、または試み。\n' +
                    '・株式会社 TrustGrowth のサービス、ホストコンピュータまたはネットワークに過負荷を与える行為やウイルスメールを送信する行為、あるいはシステムを破壊する行為、またはそれらの試み。\n' +
                    '・正当な権限無く、ユーザーの非公開データや非公開アカウントにアクセスする行為、または試み。' +
                    '・仲介手数料入金前の連絡先の交換\n' +
                    '・仲介手数料入金前に、本サービスを通さずに会員同士で直接連絡をする行為'),
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("ボーダレスワーキングの提供情報・サービス")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('ボーダレスワーキングが提供する第三者の情報（求人情報、企業情報などの情報、メンバーが登録した個人情報、データ、グラフィックス、リンクなど）は、それぞれの情報提供者の責任において提供されるものであり、株式会社TrustGrowth は、それら提供情報の正確さを保証するものではありません。ユーザーはこれを了承し、自己の責任において利用するものとします。\n' +
                    '株式会社TrustGrowth により作成された情報は、時により技術的不正確さや誤字、誤植を含むこともあります。また、ボーダレスワーキングの提供するサービスに不具合やエラー、障害が生じない事を保証するものではありません。\n' +
                    'ボーダレスワーキングの提供情報に含まれる別サイトへのリンクは、ユーザーの利便性のために提供されるものであり、それらリンクを含めることによって株式会社TurstGrowth がそのサイトの保証を行うことはありません。また、そのサイトとの商業的な関係を意味するものではありません。ボーダレスワーキングの提供情報に含まれる製品、サービスあるいは会社名には、商標あるいは知的財産権などにより法的に保護されているものがあります。株式会社TrustGrowth によるこれら商標への言及は、その準拠法により保護されないことを含意するものではありませんし、それら商標の保持者と株式会社TrustGrowth の間になんらかの商業的関係があることを含意するものではありません。'),
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("免責事項")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(
                '株式会社 TrustGrowth は、ボーダレスワーキングへの会員登録や利用から生じる一切の損害 ( 精神的苦痛、求職活動の中断、またはその他の金銭的損失を含む一切の不利益 ) に関して責任を負うものではありません。 また、いかなる状況においても、仕事あるいは人材が見つからなかったことから派生する損害を含むボーダレスワーキングの利用に起因する、法的措置、過失、契約の履行におけるデータ、利益の損失の結果による直接的または間接的な損害に対して損害賠償を負うものではありません。\n' +
                    '次の各号に該当する場合は、第三者による個人情報の取得につき、株式会社 TrustGrowth は何ら責任を負いません。\n' +
                    'ユーザー自らが、ボーダレスワーキングの機能または別の手段を用いて応募を希望する特定の企業に個人情報を明らかにする場合には、株式会社TrustGrowthはその行為に対して何らの責任を負いません。\n' +
                    'ボーダレスワーキングを通し求人情報に応募した場合は、履歴書など個人情報の企業会員への開示を了承したことになります。応募後の個人情報の管理主体は企業会員となり、これらの個人情報の取り扱いについては、株式会社 TrustGwoth は何ら責任を負いません。また、企業会員に対して履歴書を送付するなど自ら個人情報を開示した場合も、個人情報の管理主体は企業会員となり、これらの個人情報の取り扱いについては、株式会社 TrustGrowth は何ら責任を負いません。 本人特定情報以外の登録した内容により、期せずして本人が特定できてしまった場合は、株式会社 TurstGrowth はその行為に対して何ら責任を負いません。\n' +
                    'ボーダレスワーキングの提供情報からリンクしている第三者サイトへのリンクは、株式会社 TrustGrowth が管理運営するものではなく、その内容の信頼性やサイトの変更、更新などに関して、株式会社 TrustGrowth はいかなる責任も負いません。',
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("不可抗力")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    '株式会社 TrustGrowth は通常講ずるべきウイルス対策では防止できないウイルス被害、天変地異による被害、その他、株式会社 TrustGrowth の責によらない事由による被害が生じた場合には、一切責任を負わないものとします。\n' +
                        '株式会社 TrustGrowth はこれらの不可抗力に起因してボーダレスワーキングにおけるデータが消去・変更されないことを保証するものではなく、メンバーはかかるデータを自己の責任において保存するものとします。'),
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("損害賠償")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    // Strings.header_eight,
                    'ユーザーが、本規約に違反し、株式会社 TrustGrowth に対し損害を与えた場合、ユーザーは、株式会社 TrustGowth に対し、直接・間接を問わず、一切の損害賠償義務を負担することとします。'),
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("著作権 / 知的財産権について")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    // Strings.header_nine,
                    'ボーダレスワーキングの提供情報内のサービス、コンテンツ、情報の著作権および知的財産権は、株式会社 TrustGrowth に帰属します。ただし、当サイト上に掲載されている企業団体の製品名および会社名、ロゴなどは、各企業団体が所有する商標および登録商標が含まれています。'),
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("公正な使用")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    // Strings.header_ten,
                    'あらゆるコンテンツや情報を複製することは、営利営業目的で使用されず、私的あるいは教育的な目的の場合にのみ、また下記に示す著作権 / 登録商標表示が含まれている場合のみ可能です。\n' +
                        '電子的に複製する場合は、著作権 / 登録商標表示に加え、サイトへのリンクを必ず記述しなければなりません。\n' +
                        '著作権 / 登録商標が株式会社 TrustGrowth 以外に帰する部分の複製については、その旨、明記されなくてはなりません。\n' +
                        '上記制限された許可以外に、株式会社 TrustGrowth の提供情報の全部または一部を、電子的手段によるか否かに関わらず、複製頒布すること、他のサーバー上に置くこと、電子メールその他の手段で再配布することは、株式会社 TrustGrowth の許可を必要とします。\n' +
                        '株式会社 TrustGrowth の書面による（電子メール含む）許可なく、ボーダレスワーキングのオリジナル・コンテンツを修正・変更することはできません。'),
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("商業使用")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    'ボーダレスワーキングの提供コンテンツの商業目的の複製や再利用に関しては、株式会社 TrustGrowth までお問い合わせください。商業目的の複製や再利用には、パートナーシップ、提携などの契約によるものも含まれます。\n' +
                        'いずれの場合も、当サイトのリンク、バナー、ボタンを契約先のサイトあるいは電子メール文書に含めること、また、印刷・出版物における使用に関しては、URL の明示と著作権表示が要求されます。'),
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("リンク")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    '株式会社 TrustGrowth は、他サイトの運用者や電子的なテキストの配布者が、当サイトへのリンクを張ることを奨励します。当サイトへのリンクを張る前に弊社へ連絡してください。リンクは「トップレベル」のドメイン名に張っていただきます。他のいわゆる「深いレベル」へのリンクについては、個別にご相談ください。\n' +
                        'ボーダレスワーキングのサービス変更など株式会社 TrustGrowth は、事前の通知なく、ボーダレスワーキングのサービスの変更、一時的もしくは長期的な中断、または終了を行うことがあり、ユーザーはこれを承諾することとします。'),
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("本規約の変更")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    '株式会社 TrustGrowth は、事前の予告なく、本規約を随時変更することができるものとし、本ページの改訂により行われます。'),
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("管轄裁判所")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    'ユーザーと株式会社 TrustGrowth の間で生じた紛争については、東京地方裁判所を第一審の専属合意管轄裁判所とします。'),
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("準拠法")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('上記紛争の準拠法は、日本法とします。'),
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("お問い合わせ")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    '開示等のお申出、ご意見、ご質問、苦情のお申出その他個人情報の取扱いに関するお問い合わせは、以下のメールアドレスにて受け付けております。\n' +
                        '【ユーザー窓口係】\n' +
                        '株式会社 TrustGrowth サポートチーム \n' +
                        'E-mail ： support@borderless-working.jp'),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text('令和 2 年 12 月 1 日制定'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
