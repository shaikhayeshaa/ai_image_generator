import 'package:ai_image_generator/ViewModel/generative_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:stability_image_generation/stability_image_generation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final TextEditingController _promptController = TextEditingController();
  ImageAIStyle? _imageAIStyle;

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<GenerativeViewmodel>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "AI Image Generator",
          style: GoogleFonts.aboreto(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              color: Colors.white,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 3.w,
                children: [
                  Render3DButton(
                    title: "Render 3D",
                    onTap: () {
                      _imageAIStyle = ImageAIStyle.render3D;
                    },
                  ),
                  Render3DButton(
                    title: "Cyberpunk",
                    onTap: () {
                      _imageAIStyle = ImageAIStyle.cyberPunk;
                    },
                  ),
                  Render3DButton(
                    title: "Christmas",
                    onTap: () {
                      _imageAIStyle = ImageAIStyle.christmas;
                    },
                  ),
                  Render3DButton(
                    title: "Digital Painting",
                    onTap: () {
                      _imageAIStyle = ImageAIStyle.digitalPainting;
                    },
                  ),
                  Render3DButton(
                    title: "Anime",
                    onTap: () {
                      _imageAIStyle = ImageAIStyle.anime;
                    },
                  ),
                  Render3DButton(
                    title: "Cartoon",
                    onTap: () {
                      _imageAIStyle = ImageAIStyle.cartoon;
                    },
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.only(top: 4.h, left: 5.w, right: 5.w),
              child: TextField(
                controller: _promptController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                  ),
                  hintText: "Enter your prompt...",
                  hintStyle: GoogleFonts.aboreto(
                    fontSize: 16,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 3.h, bottom: 3.h),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (_promptController.text.trim().isNotEmpty &&
                      _imageAIStyle != null) {
                    vm.generateImage(
                        _promptController.text.trim(), _imageAIStyle!);
                  } else if (_promptController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter a prompt"),
                      ),
                    );
                  } else if (_imageAIStyle == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please select an image style"),
                      ),
                    );
                  }
                },
                child: Text(
                  "Generate Image",
                  style: GoogleFonts.aboreto(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Consumer(builder: (context, GenerativeViewmodel vm, child) {
              return Padding(
                padding: EdgeInsets.only(
                  left: 5.w,
                  right: 5.w,
                ),
                child: Container(
                  height: 50.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: vm.isLoading
                      ? SpinKitThreeBounce(
                          color: Colors.white,
                          size: 18.sp,
                        )
                      : vm.generatedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.memory(
                                vm.generatedImage!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Center(
                              child: Icon(
                                Icons.image,
                                size: 35.sp,
                                color: Colors.white,
                              ),
                            ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

class Render3DButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;

  const Render3DButton({super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        splashColor: Colors.white24,
        highlightColor: Colors.white10,
        child: Container(
          width: 30.w,
          height: 10.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white),
          ),
          child: Center(
              child: Text(
            title,
            style: GoogleFonts.adventPro(color: Colors.white),
          )),
        ),
      ),
    );
  }
}
